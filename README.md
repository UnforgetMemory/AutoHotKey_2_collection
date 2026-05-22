# AutoHotKey_2_collection

AutoHotkey v2 脚本合集，用于提升 Windows 日常操作效率。

## 脚本列表

### 📁 RenameFileNameToTimestamp.ahk

资源管理器文件批量重命名工具。选中文件后按 `Ctrl+Alt+F2`，自动将文件名替换为当前时间戳。

**使用方式：**
1. 在资源管理器（或桌面）选中一个或多个文件/文件夹
2. 按下 `Ctrl+Alt+F2`
3. 文件名自动重命名为 `yyyyMMddHHmm_序号.扩展名` 格式
4. 同一批选中的文件共享同一个时间戳，通过递增序号区分

**支持的格式：**

| 类别 | 格式 |
|------|------|
| 视频 | mp4, mkv, avi, mov, flv, wmv, rmvb, 3gp, ts, m4v, mpg, mpeg, vob, f4v, mts, m2ts, divx, hevc, h265 |
| 图片 | jpg, jpeg, png, bmp, gif, webp |
| 音频 | mp3, wav, flac, ogg, aac, m4a |
| 压缩包 | zip, rar, 7z, tar, gz, bz2, xz, zst |

**特性：**
- 支持多标签页资源管理器（仅处理当前激活标签）
- 支持桌面图标选择
- 支持文件与文件夹混合选择
- 文件名冲突自动添加 `(2)、(3)` 递增后缀
- 若文件已是指定时戳名称则自动跳过，避免重复重命名
- 重命名完成后自动刷新资源管理器

**环境要求：**
- Windows 11（理论上支持 Win10+）
- AutoHotkey v2.0+

## 安装

```powershell
# 确保已安装 AutoHotkey v2
# https://www.autohotkey.com/

# 克隆仓库
git clone https://github.com/UnforgetMemory/AutoHotKey_2_collection.git

# 直接运行脚本，或编译为 exe 使用
# 编译: 右键脚本 → Compile (GUI) 或运行:
Ahk2Exe.exe /in RenameFileNameToTimestamp.ahk /out RenameFileNameToTimestamp.exe
```

## License

MIT
