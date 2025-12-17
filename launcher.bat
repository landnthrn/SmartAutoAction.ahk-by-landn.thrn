@echo off
REM SmartAutoAction Launcher - Always uses AutoHotkey v2
REM This ensures the script runs with the correct version regardless of updates

REM Parameters:
REM %1 = mode ("regular" or "shiftq")

if "%1"=="" (
    echo Null ^> Don't worry about this file :) Just for maintence of the main .bat
    pause
    exit /b 1
)

REM Try to find AutoHotkey v2 in common locations
set "AHK_PATH="

REM Check Program Files (64-bit)
if exist "C:\Program Files\AutoHotkey\v2\AutoHotkey64.exe" (
    set "AHK_PATH=C:\Program Files\AutoHotkey\v2\AutoHotkey64.exe"
    goto :configure_and_run
)

REM Check Program Files (32-bit)
if exist "C:\Program Files\AutoHotkey\v2\AutoHotkey32.exe" (
    set "AHK_PATH=C:\Program Files\AutoHotkey\v2\AutoHotkey32.exe"
    goto :configure_and_run
)

REM Check Program Files (x86) for 32-bit
if exist "C:\Program Files (x86)\AutoHotkey\v2\AutoHotkey32.exe" (
    set "AHK_PATH=C:\Program Files (x86)\AutoHotkey\v2\AutoHotkey32.exe"
    goto :configure_and_run
)

REM Check if AutoHotkey v2 is in PATH
where AutoHotkey64.exe >nul 2>&1
if %errorlevel%==0 (
    set "AHK_PATH=AutoHotkey64.exe"
    goto :configure_and_run
)

where AutoHotkey32.exe >nul 2>&1
if %errorlevel%==0 (
    set "AHK_PATH=AutoHotkey32.exe"
    goto :configure_and_run
)

REM If not found, show error
echo AutoHotkey v2 not found! Please install AutoHotkey v2.
echo Download from: https://www.autohotkey.com/
pause
exit /b 1

:configure_and_run
cd /d "%~dp0"

REM Launch the appropriate script based on mode
if "%1"=="shiftq" (
    start "" "%AHK_PATH%" "%~dp0smartautoaction_shiftq.ahk"
) else (
    start "" "%AHK_PATH%" "%~dp0smartautoaction.ahk"
)
