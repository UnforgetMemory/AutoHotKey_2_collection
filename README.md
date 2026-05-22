# 🪄 AutoHotKey_2_Collection

> AutoHotkey v2 脚本合集 · 提升 Windows 日常操作效率

[![Build](https://github.com/UnforgetMemory/AutoHotKey_2_collection/actions/workflows/build.yml/badge.svg)](https://github.com/UnforgetMemory/AutoHotKey_2_collection/actions/workflows/build.yml)

[🌐 English Version](./README_EN.md)

---

## 📑 目录

| # | 脚本 | 简介 |
|---|------|------|
| ① | [📁 RenameFileNameToTimestamp](#rename) | 批量时间戳重命名 |
| ② | [🔊 AudioMediaController](#audio) | 全局媒体控制快捷键 |
|   | [📥 安装](#installation) | 安装指南 |
|   | [📄 许可协议](#license) | MIT |

---

<a id="rename"></a>

## ① 📁 RenameFileNameToTimestamp

> **快捷键：`Ctrl + Alt + F2`**

批量重命名资源管理器（或桌面）中选中的文件/文件夹为 `yyyyMMddHHmm_序号.扩展名` 格式。

### 使用方法

1. 在资源管理器或桌面选中一个或多个文件/文件夹
2. 按下 `Ctrl + Alt + F2`
3. 文件名自动重命名为 `yyyyMMddHHmm_N.ext` 格式

> 同一批选中的文件共用一个时间戳，通过递增序号 `_1`, `_2`, `_3`… 区分。

### 支持格式

| 类别 | 格式 |
|------|------|
| 视频 | `mp4`, `mkv`, `avi`, `mov`, `flv`, `wmv`, `rmvb`, `3gp`, `ts`, `m4v`, `mpg`, `mpeg`, `vob`, `f4v`, `mts`, `m2ts`, `divx`, `hevc`, `h265` |
| 图片 | `jpg`, `jpeg`, `png`, `bmp`, `gif`, `webp` |
| 音频 | `mp3`, `wav`, `flac`, `ogg`, `aac`, `m4a` |
| 压缩包 | `zip`, `rar`, `7z`, `tar`, `gz`, `bz2`, `xz`, `zst` |

### 特性

- ✅ 多标签页资源管理器支持 —— 仅处理当前激活标签页
- ✅ 桌面图标选择 —— 支持选中桌面文件
- ✅ 文件与文件夹混合选择
- ✅ 文件名冲突自动添加 `(2)(3)` 递增后缀
- ✅ 已是指定时戳名的文件自动跳过，避免重复重命名
- ✅ 重命名完成后自动刷新资源管理器

### 环境要求

- **操作系统：** Windows 11+（Win10 理论上可用）
- **运行时：** [AutoHotkey v2.0+](https://www.autohotkey.com/)

---

<a id="audio"></a>

## ② 🔊 AudioMediaController

> **全局热键**

全局媒体控制快捷键，适用于主流播放器（浏览器、PotPlayer、Spotify、网易云音乐等）。

### 快捷键

| 快捷键 | 功能 |
|--------|------|
| `Ctrl + Alt + Space` | 播放 / 暂停 |
| `Ctrl + Alt + ←` | 上一曲 |
| `Ctrl + Alt + →` | 下一曲 |
| `Ctrl + Alt + ↑` | 音量增加 |
| `Ctrl + Alt + ↓` | 音量减小 |

### 环境要求

- **操作系统：** Windows 11+（Win10 理论上可用）
- **运行时：** [AutoHotkey v2.0+](https://www.autohotkey.com/)

---

<a id="installation"></a>

## 📥 安装

```powershell
# 1. 安装 AutoHotkey v2
#    https://www.autohotkey.com/

# 2. 克隆仓库
git clone https://github.com/UnforgetMemory/AutoHotKey_2_collection.git

# 3. 直接运行脚本，或编译为 exe

#    编译单个脚本:
Ahk2Exe.exe /in RenameFileNameToTimestamp.ahk /out RenameFileNameToTimestamp.exe

#    或通过 CI 工作流一键编译:
#    → GitHub 仓库 → Actions → "Build AHK" → Run workflow
```

> **提示：** 右键 `.ahk` 文件选择 **Compile** 即可编译（需安装 Ahk2Exe）。

---

<a id="license"></a>

## 📄 许可协议

[MIT](./LICENSE) © [UnforgetMemory](https://github.com/UnforgetMemory)
