#Requires AutoHotkey v2.0
#SingleInstance Force

; 定义资源管理器窗口组（Explorer 和 桌面）
GroupAdd("ExplorerDesktopGroup", "ahk_class ExploreWClass")
GroupAdd("ExplorerDesktopGroup", "ahk_class CabinetWClass")
GroupAdd("ExplorerDesktopGroup", "ahk_class Progman")
GroupAdd("ExplorerDesktopGroup", "ahk_class WorkerW")

; 获取允许处理的文件扩展名列表（静态初始化，仅构建一次）
GetAllowedExt() {
    static ext := Map(
        ; 视频
        ".mp4", true, ".mkv", true, ".avi", true, ".mov", true, ".flv", true,
        ".wmv", true, ".rmvb", true, ".3gp", true, ".ts", true, ".m4v", true,
        ".mpg", true, ".mpeg", true, ".vob", true, ".f4v", true, ".mts", true,
        ".m2ts", true, ".divx", true, ".hevc", true, ".h265", true,
        ; 图片
        ".jpg", true, ".jpeg", true, ".png", true, ".bmp", true, ".gif", true,
        ".webp", true,
        ; 音频
        ".mp3", true, ".wav", true, ".flac", true, ".ogg", true, ".aac", true,
        ".m4a", true,
        ; 压缩包
        ".zip", true, ".rar", true, ".7z", true, ".tar", true,
        ".gz", true, ".bz2", true, ".xz", true, ".zst", true
    )
    return ext
}

#HotIf WinActive("ahk_group ExplorerDesktopGroup")

ExplorerSelectedItem(activewindow := True) {
    filepaths := ExplorerSelectedItems(activewindow)
    return filepaths.has(1) ? filepaths[1] : ""
}

ExplorerSelectedItems(activewindow := True) {
    filepaths := []
    WinExistOrActive := (activewindow) ? WinActive : WinExist

    ; 优先处理资源管理器窗口
    if (hwnd := WinExistOrActive("ahk_class ExploreWClass"))
    or (hwnd := WinExistOrActive("ahk_class CabinetWClass")) {

        ; 1) 尝试获取“当前激活标签”的窗口对象
        window := ExplorerActiveTabWindow(hwnd)

        if IsSet(window) {
            ; 成功锁定当前标签：只取当前标签的选中项
            try {
                for item in window.Document.SelectedItems
                    filepaths.push(item.Path)
            }
        } else {
            ; 2) 回退：遍历该窗口的所有标签，合并选中项
            for win in ComObject("Shell.Application").Windows {
                if (win.hwnd != hwnd)
                    continue
                ; 每个标签是一个 Document（ShellFolderView 或 HTMLDocument）
                try {
                    for item in win.Document.SelectedItems
                        filepaths.push(item.Path)
                }
            }
        }
    }

    ; 桌面（Progman / WorkerW）
    if WinActive("ahk_class WorkerW") || WinActive("ahk_class Progman") {
        try hwnd := ControlGetHwnd("SysListView321", "ahk_class Progman")
        hwnd := hwnd || ControlGetHwnd('SysListView321', "A")
        loop parse ListViewGetContent("Selected Col1", hwnd), "`n", "`r"
            filepaths.push(A_Desktop "\" A_LoopField)
    }
    return filepaths
}

Explorer(activewindow := True) {
    WinExistOrActive := (activewindow) ? WinActive : WinExist
    if (hwnd := WinExistOrActive("ahk_class ExploreWClass"))
    or (hwnd := WinExistOrActive("ahk_class CabinetWClass")) {
        window := ExplorerActiveTabWindow(hwnd) ; 先尝试当前标签
        if !IsSet(window)
            window := ExplorerAnyWindow(hwnd)    ; 回退：同窗口内的任一标签
        if IsSet(window) {
            directory := Type(window.Document) == "ShellFolderView"
                ? window.Document.Folder.Self.Path
                : window.LocationURL
        }
    }
    if WinActive("ahk_class WorkerW") || WinActive("ahk_class Progman")
        directory := A_Desktop
    return directory ?? ""
}

; 获取与 hwnd 匹配的任一 Explorer 窗口对象（不区分标签）
ExplorerAnyWindow(hwnd) {
    for window in ComObject("Shell.Application").Windows {
        if (window.hwnd = hwnd)
            return window
    }
    return
}

; 精确获取“当前激活标签”的窗口对象；失败返回未设置
ExplorerActiveTabWindow(hwnd) {
    ; Windows 11 标签控制类名
    activeTab := 0
    try activeTab := ControlGetHwnd("ShellTabWindowClass1", hwnd)
    if !activeTab {
        ; 兼容旧式（例如 IE）
        try activeTab := ControlGetHwnd("TabWindowClass1", hwnd)
    }

    for window in ComObject("Shell.Application").Windows {
        if (window.hwnd != hwnd)
            continue

        ; 如果没有找到标签句柄，无法精确匹配，直接返回未设置，交给回退逻辑
        if !activeTab
            continue

        ; 通过 IShellBrowser 获取当前活动的 ShellView（Lexikos 的思路）
        try {
            static IID_IShellBrowser := "{000214E2-0000-0000-C000-000000000046}"
            IShellBrowser := ComObjQuery(window, IID_IShellBrowser, IID_IShellBrowser)
            ; GetWindow (index 3) 返回当前 tab 的窗口句柄
            ComCall(GetWindow := 3, IShellBrowser, "uint*", &thisTab := 0)
            if (thisTab = activeTab) {
                return window
            }
        }
    }
    return ; 未能精确匹配当前标签
}

; 当在资源管理器中按 Ctrl+Alt+F2 时触发
^!F2::
{
    filePaths := ExplorerSelectedItems()

    if (!IsSet(filePaths) || filePaths.Length = 0) {
        MsgBox("请先选择一个或多个文件或文件夹。", "未选择项目", "0x30")
        return
    }

    ; 获取允许的文件扩展名列表（静态初始化 Map，仅首次调用时构建）
    allowedExt := GetAllowedExt()

    count := 0
    for item in filePaths {
        count++
        path := item
        SplitPath path, &name, &dir, &ext

        isFolder := false

        if (DirExist(path)) {
            ext := ""
            isFolder := true
        }
        else if (FileExist(path)) {
            if !allowedExt.Has("." . StrLower(ext)) {
                MsgBox("跳过不支持的文件类型: " . name . "." . ext, "不支持", "0x30")
                continue
            }
        } else {
            continue
        }

        utcNow := FormatTime(, "yyyyMMddHHmm")
        newName := utcNow . "_" . count . (ext ? "." . ext : "")
        newPath := dir . "\" . newName

        ; 若文件已是目标文件名（newPath == path），跳过避免自我重命名冲突
        if (newPath = path)
            continue

        ; 唯一化：若目标名已存在，追加递增后缀 (2), (3)...
        if (FileExist(newPath) || DirExist(newPath)) {
            SplitPath newName, , , &OutExt, &OutNameNoExt
            i := 2
            Loop {
                suffix := OutExt = "" ? "" : "." . OutExt
                newPath := dir . "\" . OutNameNoExt . " (" . i . ")" . suffix
                if !FileExist(newPath) && !DirExist(newPath)
                    break
                i++
            }
        }

        try {
            if isFolder
                DirMove(path, newPath)
            else
                FileMove(path, newPath)
        } catch Error as e {
            MsgBox("重命名失败: " . e.Message)
        }
    }

    ; 刷新资源管理器
    DllCall("Shell32.dll\SHChangeNotify", "UInt", 0x00002000, "UInt", 0x0000, "UInt", 0, "UInt", 0)
}

#HotIf