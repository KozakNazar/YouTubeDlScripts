@echo off
setlocal enabledelayedexpansion
set "DOWNLOAD_DIR=%~dp0YtDlpDownloads"
set "MAX_HEIGHT=720"

set "RAW_URL=%*"

if "!RAW_URL!"=="" (
    echo Please enter YouTube Channel URL or @username:
    echo Example: https://www.youtube.com/c/ChannelName
    echo Example: https://www.youtube.com/@UserName  
    echo Example: @UserName
    echo.
    set /p "RAW_URL=URL: "
)

if "!RAW_URL!"=="" (
    echo No URL provided. Exiting.
    pause
    exit /b 1
)

REM Обробка URL (додаємо https:// якщо починається з @)
if "!RAW_URL:~0,1!"=="@" (
    set "URL=https://www.youtube.com/!RAW_URL!"
) else (
    if "!RAW_URL:"=!"=="!RAW_URL!" (
        set "URL="!RAW_URL!""
    ) else (
        set "URL=!RAW_URL!"
    )
)

echo.
echo Downloading ENTIRE CHANNEL...
echo This will download all videos and playlists!
echo Press Ctrl+C to cancel if needed.
echo.

REM Завантаження всього каналу
yt-dlp -f "bv*[height<=!MAX_HEIGHT!]+ba[language=uk]/bv*[height<=!MAX_HEIGHT!]+ba/b" ^
       -o "!DOWNLOAD_DIR!\%%(channel,.80)s\%%(playlist_title|Videos)s\%%(playlist_index|)s%%(playlist_index& - |)s%%(upload_date|)s%%(upload_date& - |)s%%(title,.80)s [%%(format_note)s].%%(ext)s" ^
       --merge-output-format mp4 ^
       --embed-metadata ^
       --embed-thumbnail ^
       --no-overwrites ^
       --ignore-no-formats-error ^
       --continue ^
       --progress ^
       --windows-filenames ^
       --compat-options filename-sanitization ^
       --yes-playlist ^
       --download-archive "!DOWNLOAD_DIR!\downloaded.txt" ^
       --write-info-json ^
       --write-description ^
       --match-filter "!is_live & !is_upcoming" ^
       "!URL!"

echo.
echo Channel download completed!
echo Videos saved in: !DOWNLOAD_DIR!
pause