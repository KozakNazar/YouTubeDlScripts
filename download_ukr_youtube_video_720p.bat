@echo off
REM setlocal enabledelayedexpansion REM для !variable!
set "DOWNLOAD_DIR=%~dp0YtDlpDownloads"
set "MAX_HEIGHT=720"

REM set "RAW_URL=%~1"
set "RAW_URL=%*"

if "%RAW_URL%"=="" (
    echo Please enter YouTube video URL:
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
       -o "%DOWNLOAD_DIR%\%%(channel,.80)s\%%(title,.80)s.%%(ext)s" ^
       --merge-output-format mp4 ^
       --embed-metadata ^
       --embed-thumbnail ^
       --no-overwrites ^
       --ignore-no-formats-error ^
       --continue ^
       --progress ^
       --windows-filenames ^
       --compat-options filename-sanitization ^
       %URL%

echo Done!

pause
