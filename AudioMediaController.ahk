#Requires AutoHotkey v2.0
#SingleInstance Force

; 全局媒体控制快捷键（适用于主流播放器：浏览器、PotPlayer、Spotify 等）

; Ctrl + Alt + Space → 播放 / 暂停
^!Space::Send "{Media_Play_Pause}"

; Ctrl + Alt + ← → 上一曲
^!Left::Send "{Media_Prev}"

; Ctrl + Alt + → → 下一曲
^!Right::Send "{Media_Next}"

; Ctrl + Alt + ↑ → 音量增加
^!Up::Send "{Volume_Up}"

; Ctrl + Alt + ↓ → 音量减小
^!Down::Send "{Volume_Down}"
