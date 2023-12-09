# Convert video to H264 using ffmpeg, HW-accelerated Intel GPUs QuickSync via Explorer right-click context menu items

## About

Convert video to H264 using Intel QSV and ffmpeg with a single Windows Explorer context menu click.

Inspired by <https://github.com/kachurovskiy/VideoContextMenu> but heavily modified to use QSV and also selectable options in PowerShell (with the help of ChatGPT).

## Installation

1. Make sure you have ffmpeg installed and added to PATH, so that typing `ffmpeg` into the Command Line works. You must have ffmpeg with QSV encoding support and Intel GPU that supports H264 HW encoding (Sandy Bridge and newer).
2. Download <https://github.com/brozkeff/ConvertVideoToH264QSVviaContextMenu> into `C:\Programs\VideoContextMenu` or elsewhere but then modify the .reg files before running them.
3. Execute `.reg` files for the fixed preset in BAT file (Q27, fast, MP4 container) or variable config dialog in PS1 file (Q20-31, variable speed profile, MP4 or MKV container). For .ps1 you need new PowerShell7+ (pwsh.exe), else modify reg file to use old powershell.exe as fallback (commented line). Both reg files add items to submenu of "Convert video" to not spam the main context menu directly with several items.

You should now have the video stabilization and converting shortcuts for all file types.

## Customization

Edit the BAT file or PS1 file locally to best fit your needs or add more shortcuts to your liking by adding more BAT files (don't forget `.reg` corresponding changes).

## Where to find output files

Conversion: in the same folder with `.mp4` extension. If such file already exists then `-h264` suffix is added to the output file name.

## Uninstall

To delete these menu items, start Windows `regedit` tool and remove corresponding items from `HKEY_CLASSES_ROOT\*\shell`
