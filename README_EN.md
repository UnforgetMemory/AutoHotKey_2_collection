# 🪄 AutoHotKey_2_Collection

> AutoHotkey v2 Script Collection · Boost your Windows daily productivity

[![Build](https://github.com/UnforgetMemory/AutoHotKey_2_collection/actions/workflows/build.yml/badge.svg)](https://github.com/UnforgetMemory/AutoHotKey_2_collection/actions/workflows/build.yml)

[📖 简体中文](./README.md)

---

## 📑 Table of Contents

| # | Script | Description |
|---|--------|-------------|
| ① | [📁 RenameFileNameToTimestamp](#rename) | Batch-rename files to timestamp |
| ② | [🔊 AudioMediaController](#audio) | Global media hotkeys |
|   | [📥 Installation](#installation) | Setup guide |
|   | [📄 License](#license) | MIT |

---

<a id="rename"></a>

## ① 📁 RenameFileNameToTimestamp

> **Hotkey: `Ctrl + Alt + F2`**

Batch-rename files/folders selected in Explorer (or on the desktop) to `yyyyMMddHHmm_sequence.ext` format.

### Usage

1. Select one or more files/folders in Explorer or on the desktop
2. Press `Ctrl + Alt + F2`
3. Names are auto-renamed to `yyyyMMddHHmm_N.ext` format

> All files in one batch share the same timestamp, differentiated by incrementing index `_1`, `_2`, `_3`…

### Supported Formats

| Category | Formats |
|----------|---------|
| Video | `mp4`, `mkv`, `avi`, `mov`, `flv`, `wmv`, `rmvb`, `3gp`, `ts`, `m4v`, `mpg`, `mpeg`, `vob`, `f4v`, `mts`, `m2ts`, `divx`, `hevc`, `h265` |
| Image | `jpg`, `jpeg`, `png`, `bmp`, `gif`, `webp` |
| Audio | `mp3`, `wav`, `flac`, `ogg`, `aac`, `m4a` |
| Archive | `zip`, `rar`, `7z`, `tar`, `gz`, `bz2`, `xz`, `zst` |

### Features

- ✅ Multi-tab Explorer support — only processes the active tab
- ✅ Desktop icon selection support
- ✅ Mixed file & folder selection
- ✅ Auto-incrementing `(2)(3)` suffix on name collision
- ✅ Skips files already bearing the target timestamp to avoid duplicate renaming
- ✅ Auto-refreshes Explorer on completion

### Requirements

- **OS:** Windows 11+ (Win10 theoretically compatible)
- **Runtime:** [AutoHotkey v2.0+](https://www.autohotkey.com/)

---

<a id="audio"></a>

## ② 🔊 AudioMediaController

> **Global Hotkeys**

Global media hotkeys compatible with major players (browsers, PotPlayer, Spotify, NetEase Music, etc.).

### Hotkeys

| Shortcut | Action |
|----------|--------|
| `Ctrl + Alt + Space` | Play / Pause |
| `Ctrl + Alt + ←` | Previous Track |
| `Ctrl + Alt + →` | Next Track |
| `Ctrl + Alt + ↑` | Volume Up |
| `Ctrl + Alt + ↓` | Volume Down |

### Requirements

- **OS:** Windows 11+ (Win10 theoretically compatible)
- **Runtime:** [AutoHotkey v2.0+](https://www.autohotkey.com/)

---

<a id="installation"></a>

## 📥 Installation

```powershell
# 1. Install AutoHotkey v2
#    https://www.autohotkey.com/

# 2. Clone the repo
git clone https://github.com/UnforgetMemory/AutoHotKey_2_collection.git

# 3. Run scripts directly, or compile to .exe

#    Compile a single script:
Ahk2Exe.exe /in RenameFileNameToTimestamp.ahk /out RenameFileNameToTimestamp.exe

#    Or use the CI workflow to compile all at once:
#    → GitHub repo → Actions → "Build AHK" → Run workflow
```

> **Tip:** Right-click any `.ahk` file and select **Compile** (requires Ahk2Exe).

---

<a id="license"></a>

## 📄 License

[MIT](./LICENSE) © [UnforgetMemory](https://github.com/UnforgetMemory)
