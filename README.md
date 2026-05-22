# 🪄 AutoHotKey_2_Collection

> **AutoHotkey v2 脚本合集 · AutoHotkey v2 Script Collection**  
> 提升 Windows 日常操作效率 — Boost your Windows daily productivity

[![Build](https://github.com/UnforgetMemory/AutoHotKey_2_collection/actions/workflows/build.yml/badge.svg)](https://github.com/UnforgetMemory/AutoHotKey_2_collection/actions/workflows/build.yml)

---

## 📑 Table of Contents · 目录

| # | Script | Description | 简介 |
|---|--------|-------------|------|
| ① | [📁 RenameFileNameToTimestamp](#rename) | Batch-rename files to timestamp | 批量时间戳重命名 |
| ② | [🔊 AudioMediaController](#audio) | Global media hotkeys | 全局媒体控制快捷键 |
|   | [📥 Installation / 安装](#installation) | Setup guide | 安装指南 |
|   | [📄 License / 许可](#license) | MIT | MIT |

---

<a id="rename"></a>

## ① 📁 RenameFileNameToTimestamp

> **AutoHotkey v2** · **快捷键: `Ctrl + Alt + F2`**

批量重命名资源管理器（或桌面）中选中的文件/文件夹为 `yyyyMMddHHmm_序号.扩展名` 格式。  
Batch-rename files/folders selected in Explorer (or on the desktop) to `yyyyMMddHHmm_sequence.ext` format.

### Usage · 用法

1. 在资源管理器或桌面选中一个或多个文件/文件夹 — Select files/folders in Explorer or on the desktop
2. 按 `Ctrl + Alt + F2` — Press `Ctrl + Alt + F2`
3. 文件名自动重命名为 `yyyyMMddHHmm_N.ext` 格式 — Names are auto-renamed to `yyyyMMddHHmm_N.ext`

> 同一批选中的文件共享一个时间戳，通过递增序号 `_1`, `_2`, `_3`… 区分。  
> All files in one batch share the same timestamp, differentiated by incrementing index `_1`, `_2`, `_3`…

### Supported Formats · 支持格式

| Category · 类别 | Formats · 格式 |
|----------------|----------------|
| Video · 视频 | `mp4`, `mkv`, `avi`, `mov`, `flv`, `wmv`, `rmvb`, `3gp`, `ts`, `m4v`, `mpg`, `mpeg`, `vob`, `f4v`, `mts`, `m2ts`, `divx`, `hevc`, `h265` |
| Image · 图片 | `jpg`, `jpeg`, `png`, `bmp`, `gif`, `webp` |
| Audio · 音频 | `mp3`, `wav`, `flac`, `ogg`, `aac`, `m4a` |
| Archive · 压缩包 | `zip`, `rar`, `7z`, `tar`, `gz`, `bz2`, `xz`, `zst` |

### Features · 特性

- ✅ 多标签页资源管理器支持 / Multi-tab Explorer support — 仅处理当前激活标签页
- ✅ 桌面图标选择 / Desktop icon selection
- ✅ 文件与文件夹混合选择 / Mixed file & folder selection
- ✅ 文件名冲突自动 `(2)(3)` 递增后缀 / Auto-incrementing suffix on name collision
- ✅ 已是指定时戳名的文件自动跳过 / Skip files already bearing the target timestamp
- ✅ 重命名完成自动刷新资源管理器 / Auto-refresh Explorer on completion

### Requirements · 环境要求

- **OS:** Windows 11+ (Win10 理论上可用 / theoretically compatible)
- **Runtime:** [AutoHotkey v2.0+](https://www.autohotkey.com/)

---

<a id="audio"></a>

## ② 🔊 AudioMediaController

> **AutoHotkey v2** · **全局热键/Global Hotkeys**

全局媒体控制快捷键，适用于主流播放器（浏览器、PotPlayer、Spotify、网易云音乐等）。  
Global media hotkeys compatible with major players (browsers, PotPlayer, Spotify, NetEase Music, etc.)

### Hotkeys · 快捷键

| Shortcut · 快捷键 | Action · 功能 |
|--------------------|---------------|
| `Ctrl + Alt + Space` | Play / Pause · 播放 / 暂停 |
| `Ctrl + Alt + ←` | Previous Track · 上一曲 |
| `Ctrl + Alt + →` | Next Track · 下一曲 |
| `Ctrl + Alt + ↑` | Volume Up · 音量增加 |
| `Ctrl + Alt + ↓` | Volume Down · 音量减小 |

### Requirements · 环境要求

- **OS:** Windows 11+ (Win10 理论上可用 / theoretically compatible)
- **Runtime:** [AutoHotkey v2.0+](https://www.autohotkey.com/)

---

<a id="installation"></a>

## 📥 Installation · 安装

```powershell
# 1. Install AutoHotkey v2 安装
#    https://www.autohotkey.com/

# 2. Clone the repo 克隆仓库
git clone https://github.com/UnforgetMemory/AutoHotKey_2_collection.git

# 3. Run scripts directly, or compile to .exe
#    直接运行脚本，或编译为 exe

#    Compile a single script 编译单个脚本:
Ahk2Exe.exe /in RenameFileNameToTimestamp.ahk /out RenameFileNameToTimestamp.exe

#    Or use the CI workflow to compile all scripts at once:
#    或通过 CI 工作流一键编译全部脚本:
#    → GitHub repo → Actions → "Build AHK" → Run workflow
```

> **Tip:** Right-click any `.ahk` file and select **Compile** (if Ahk2Exe is installed with AHK).  
> **提示:** 右键 `.ahk` 文件选择 **Compile** 即可编译（需安装 Ahk2Exe）。

---

<a id="license"></a>

## 📄 License · 许可

[MIT](./LICENSE) © [UnforgetMemory](https://github.com/UnforgetMemory)
