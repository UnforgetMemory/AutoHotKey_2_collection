#Requires AutoHotkey v2.0
#SingleInstance Force

; 定义资源管理器窗口组（Explorer 和 桌面）
GroupAdd("ExplorerDesktopGroup", "ahk_class ExploreWClass")
GroupAdd("ExplorerDesktopGroup", "ahk_class CabinetWClass")
GroupAdd("ExplorerDesktopGroup", "ahk_class Progman")
GroupAdd("ExplorerDesktopGroup", "ahk_class WorkerW")

#HotIf WinActive("ahk_group ExplorerDesktopGroup")

; 当在资源管理器中按 Ctrl+Alt+F2 时触发
^!F2::
{
    ; 获取当前活动窗口的 ShellFolderView 对象
    winClass := WinGetClass("ahk_id" . hWnd := WinExist("A"))
    if !(winClass ~= "^(Progman|WorkerW|(Cabinet|Explore)WClass)$")
        Return
    shellWindows := ComObject("Shell.Application").Windows
    if (winClass ~= "Progman|WorkerW")
        shellFolderView := shellWindows.Item(ComValue(VT_UI4 := 0x13, SWC_DESKTOP := 0x8)).Document
    else {
        for window in shellWindows
            if (hWnd = window.HWND) && (shellFolderView := window.Document)
                break
    }

    if (!IsObject(shellFolderView))
        Return

    ; 支持的文件扩展名
    allowedExt := Map(
        ".mp4", true, ".mkv", true, ".avi", true, ".mov", true, ".flv", true,
        ".jpg", true, ".jpeg", true, ".png", true, ".bmp", true, ".gif", true, ".webp", true
    )

    count := 0
    for item in shellFolderView.SelectedItems {
        count++
        path := item.Path

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
                ext := RegExMatch(newName, "\.\w+$") ? SubStr(newName, InStr(newName, ".", -1)) : ""
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