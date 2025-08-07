#Requires AutoHotkey v2.0
#SingleInstance Force

; 定义资源管理器窗口组（Explorer 和 桌面）
GroupAdd("ExplorerDesktopGroup", "ahk_class ExploreWClass")
GroupAdd("ExplorerDesktopGroup", "ahk_class CabinetWClass")
GroupAdd("ExplorerDesktopGroup", "ahk_class Progman")
GroupAdd("ExplorerDesktopGroup", "ahk_class WorkerW")


#HotIf WinActive("ahk_group ExplorerDesktopGroup")

ExplorerSelectedItem(activewindow := True) {
    filepaths := ExplorerSelectedItems(activewindow)
    return filepaths.has(1) ? filepaths[1] : ""
}

ExplorerSelectedItems(activewindow := True) {
    ; Based on mikeyww - https://www.autohotkey.com/boards/viewtopic.php?p=509165#p509165
    filepaths := []
    WinExistOrActive := (activewindow) ? WinActive : WinExist
    if (hwnd := WinExistOrActive("ahk_class ExploreWClass"))
        or (hwnd := WinExistOrActive("ahk_class CabinetWClass")) {
        window := ExplorerTab(hwnd)
        for item in window.Document.SelectedItems
            filepaths.push(item.Path)
    }
    if WinActive("ahk_class WorkerW") || WinActive("ahk_class Progman") {
        try hwnd := ControlGetHwnd("SysListView321", "ahk_class Progman")
        hwnd := hwnd || ControlGetHwnd('SysListView321', "A")
        Loop Parse ListViewGetContent("Selected Col1", hwnd), "`n", "`r"
            filepaths.push(A_Desktop "\" A_LoopField)
    }
    return filepaths ; Returned array could be empty with zero length
}

Explorer(activewindow := True) {
    WinExistOrActive := (activewindow) ? WinActive : WinExist
    if (hwnd := WinExistOrActive("ahk_class ExploreWClass"))
        or (hwnd := WinExistOrActive("ahk_class CabinetWClass")) {
        window := ExplorerTab(hwnd)
        directory := Type(window.Document) == "ShellFolderView"
            ? window.Document.Folder.Self.Path
            : window.LocationURL             ; "HTMLDocument"
    }
    if WinActive("ahk_class WorkerW") || WinActive("ahk_class Progman")
        directory := A_Desktop
    return directory ?? "" ; Returns the empty string if the directory is not found
}

ExplorerTab(hwnd) {
    ; Thanks Lexikos - https://www.autohotkey.com/boards/viewtopic.php?f=83&t=109907
    try activeTab := ControlGetHwnd("ShellTabWindowClass1", hwnd) ; File Explorer (Windows 11)
    catch
        try activeTab := ControlGetHwnd("TabWindowClass1", hwnd) ; IE
    for window in ComObject("Shell.Application").Windows {
        if (window.hwnd != hwnd)
            continue
        if IsSet(activeTab) { ; The window has tabs, so make sure this is the right one.
            static IID_IShellBrowser := "{000214E2-0000-0000-C000-000000000046}"
            IShellBrowser := ComObjQuery(window, IID_IShellBrowser, IID_IShellBrowser)
            ComCall(GetWindow := 3, IShellBrowser, "uint*", &thisTab := 0)
            if (thisTab != activeTab)
                continue
        }
        return window ; Returns a ComObject with a .hwnd property
    }
    throw Error("Could not locate active tab in Explorer window.")
}

; 当在资源管理器中按 Ctrl+Alt+F2 时触发
^!F2::
{
    filePaths := ExplorerSelectedItems()

    if (!IsSet(filePaths) || filePaths.Length = 0) {
        MsgBox("请先选择一个或多个文件或文件夹。", "未选择项目", "0x30")
        return
    }

    ; 支持的文件扩展名
    allowedExt := Map(
        ".mp4", true, ".mkv", true, ".avi", true, ".mov", true, ".flv", true,
        ".jpg", true, ".jpeg", true, ".png", true, ".bmp", true, ".gif", true, ".webp", true
    )

    count := 0
    for item in filePaths {
        count++
        path := item

        SplitPath path, &name, &dir, &ext

        isFolder := false

        ;检查路径是文件还是文件夹
        if (DirExist(path)) {
            ext := ""  ;
            isFolder := true
        }
        else if (FileExist(path)) {
            if !allowedExt.Has("." . ext) {
                MsgBox("跳过不支持的文件类型: " . name . "." . ext, "不支持", "0x30")
                continue
            }
        } else {
            continue
        }

        ; 获取当前 UTC 时间戳
        utcNow := FormatTime(, "yyyyMMddHHmm")

        ; 构造新的文件名
        newName := utcNow . "_" . count . (ext ? "." . ext : "")
        newPath := dir . "\" . newName

        ; 确保新文件名唯一
        if (FileExist(newPath) || (isFolder && DirExist(newPath))) {
            if isFolder {
                base := newName
                ext := ""
            } else {
                base := RegExReplace(newName, "(?:\.\w+)?$")
                ext := RegExMatch(newName, "\.\w+$") ? SubStr(newName, InStr(newName, ".", StrLen(newName))) : ""
            }

            i := 2
            while (FileExist(dir . "\" . base . " (" . i . ")" . ext) || (isFolder && DirExist(dir . "\" . base . " (" . i . ")" . ext))) {
                i++
            }
            newPath := dir . "\" . base . " (" . i . ")" . ext
        }


        ; 重命名操作
        try {
            if isFolder
                DirMove(path, newPath)
            else
                FileMove(path, newPath)
        } catch Error as e {
            MsgBox("重命名失败: " . e.Message)
        }
    }

    ; 刷新资源管理器窗口
    DllCall("Shell32.dll\SHChangeNotify", "UInt", 0x00002000, "UInt", 0x0000, "UInt", 0, "UInt", 0)
}
Return

#HotIf