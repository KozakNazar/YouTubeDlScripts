@echo off
setlocal enabledelayedexpansion
set "DOWNLOAD_DIR=%~dp0YtDlpDownloads"
set "MAX_HEIGHT=720"

set "RAW_URL=%*"

if "!RAW_URL!"=="" (
    echo Please enter YouTube Channel URL 
	REM echo or @username:
    echo Example: https://www.youtube.com/c/ChannelName
    echo Example: https://www.youtube.com/@UserName  
    REM echo Example: @UserName
    echo.
    set /p "RAW_URL=URL: "
)

if "!RAW_URL!"=="" (
    echo No URL provided. Exiting.
    pause
    exit /b 1
)

REM Запит часового проміжку
echo.
echo Enter start date (YYYYMMDD) or press Enter to skip:
set /p "DATE_AFTER=After: "
echo Enter end date (YYYYMMDD) or press Enter to skip:
set /p "DATE_BEFORE=Before: "

REM Формування параметрів дати
set "DATE_OPTS="
if not "!DATE_AFTER!"=="" set "DATE_OPTS=!DATE_OPTS! --dateafter !DATE_AFTER!"
if not "!DATE_BEFORE!"=="" set "DATE_OPTS=!DATE_OPTS! --datebefore !DATE_BEFORE!"

REM REM Обробка URL (додаємо https:// якщо починається з @)
REM if "!RAW_URL:~0,1!"=="@" (
REM     set "URL=https://www.youtube.com/!RAW_URL!"
REM ) else (
REM     if "!RAW_URL:"=!"=="!RAW_URL!" (
REM         set "URL="!RAW_URL!""
REM     ) else (
            set "URL=!RAW_URL!"
REM     )
REM )

echo.
echo Downloading ENTIRE CHANNEL with date filters...
echo Path: !DOWNLOAD_DIR!
if not "!DATE_OPTS!"=="" echo Filters: !DATE_OPTS!
echo This will download all videos and playlists!
echo Press Ctrl+C to cancel if needed.
echo.

REM Завантаження всього каналу
yt-dlp !DATE_OPTS! ^
       -f "bv*[height<=%MAX_HEIGHT%]+ba[language=uk]+ba[language=en]+ba[language=ru]/bv*[height<=%MAX_HEIGHT%]+ba[language=uk]+ba[language=us]+ba[language=ru]/bv*[height<=%MAX_HEIGHT%]+ba[language=uk]+ba[language=en-US]+ba[language=ru]/bv*[height<=%MAX_HEIGHT%]+ba[language=uk]+ba[language=en]/bv*[height<=%MAX_HEIGHT%]+ba[language=uk]+ba[language=us]/bv*[height<=%MAX_HEIGHT%]+ba[language=uk]+ba[language=en-US]/bv*[height<=%MAX_HEIGHT%]+ba[language=uk]+ba[language=ru]/bv*[height<=%MAX_HEIGHT%]+ba[language=uk]/bv*[height<=%MAX_HEIGHT%]+ba[language=ru]+ba[language=en]/bv*[height<=%MAX_HEIGHT%]+ba[language=ru]+ba[language=us]/bv*[height<=%MAX_HEIGHT%]+ba[language=ru]+ba[language=en-US]/bv*[height<=%MAX_HEIGHT%]+ba[language=en]/bv*[height<=%MAX_HEIGHT%]+ba[language=us]/bv*[height<=%MAX_HEIGHT%]+ba[language=en-US]/bv*[height<=%MAX_HEIGHT%]+ba/b" ^
       -o "!DOWNLOAD_DIR!\%%(channel,.80)s\%%(playlist_title|Videos)s\%%(playlist_index|)s%%(playlist_index& - |)s%%(upload_date|)s%%(upload_date& - |)s%%(title,.80)s [%%(format_note)s].%%(ext)s" ^
       --merge-output-format mp4 ^
       --audio-multistreams ^
	   --extractor-args "youtube:player_client=all" ^
       --embed-metadata ^
       --embed-thumbnail ^
       --no-overwrites ^
       --ignore-no-formats-error ^
       --continue ^
       --progress ^
       --windows-filenames ^
       --compat-options filename-sanitization ^
       --yes-playlist ^
       %URL%

echo.
echo Channel download completed!
echo Videos saved in: !DOWNLOAD_DIR!
pause