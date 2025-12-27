@echo off
REM setlocal enabledelayedexpansion REM для !variable!
set "DOWNLOAD_DIR=%~dp0YtDlpDownloads"
set "MAX_HEIGHT=720"

REM set "RAW_URL=%~1"
set "RAW_URL=%*"

if "%RAW_URL%"=="" (
    echo Please enter YouTube URL:
    set /p "RAW_URL=URL: "
)

if "%RAW_URL%"=="" (
    echo No URL provided. Exiting.
    pause
    exit /b 1
)

if "%RAW_URL:"=%"=="%RAW_URL%" (
    set "URL="%RAW_URL%""
) else (
	set "URL=%RAW_URL%"
)

echo Downloading...
echo.

yt-dlp -f "bv*[height<=%MAX_HEIGHT%]+ba[language=uk]/bv*[height<=%MAX_HEIGHT%]+ba/b" ^
       -o "%DOWNLOAD_DIR%\%%(playlist_title)s\%%(playlist_index)02d - %%(title)s.%%(ext)s" ^
       --merge-output-format mp4 ^
       --no-overwrites ^
       --ignore-no-formats-error ^
       --continue ^
       --yes-playlist ^
       --progress ^
       %URL%

echo Done!
pause