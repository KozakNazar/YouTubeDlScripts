@echo off
REM setlocal enabledelayedexpansion REM для !variable!
set "DOWNLOAD_DIR=%~dp0YtDlpDownloads"

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

yt-dlp -f "bv+ba[language=uk]+ba[language=en]+ba[language=ru]/bv+ba[language=uk]+ba[language=us]+ba[language=ru]/bv+ba[language=uk]+ba[language=en-US]+ba[language=ru]/bv+ba[language=uk]+ba[language=en]/bv+ba[language=uk]+ba[language=us]/bv+ba[language=uk]+ba[language=en-US]/bv+ba[language=uk]+ba[language=ru]/bv+ba[language=uk]/bv+ba[language=ru]+ba[language=en]/bv+ba[language=ru]+ba[language=us]/bv+ba[language=ru]+ba[language=en-US]/bv+ba[language=en]/bv+ba[language=us]/bv+ba[language=en-US]/bv+ba/b" ^
       -o "%DOWNLOAD_DIR%\%%(channel,.80)s\%%(title,.80)s [%%(format_note)s].%%(ext)s" ^
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

echo Done!
pause