@echo off
REM SmartAutoAction WITH SHIFT + Q Launcher - Always uses AutoHotkey v2
REM This ensures the script runs with the correct version regardless of updates

REM Try to find AutoHotkey v2 in common locations
set "AHK_PATH="

REM Check Program Files (64-bit)
if exist "C:\Program Files\AutoHotkey\v2\AutoHotkey64.exe" (
    set "AHK_PATH=C:\Program Files\AutoHotkey\v2\AutoHotkey64.exe"
    goto :found
)

REM Check Program Files (32-bit)
if exist "C:\Program Files\AutoHotkey\v2\AutoHotkey32.exe" (
    set "AHK_PATH=C:\Program Files\AutoHotkey\v2\AutoHotkey32.exe"
    goto :found
)

REM Check Program Files (x86) for 32-bit
if exist "C:\Program Files (x86)\AutoHotkey\v2\AutoHotkey32.exe" (
    set "AHK_PATH=C:\Program Files (x86)\AutoHotkey\v2\AutoHotkey32.exe"
    goto :found
)

REM Check if AutoHotkey v2 is in PATH
where AutoHotkey64.exe >nul 2>&1
if %errorlevel%==0 (
    set "AHK_PATH=AutoHotkey64.exe"
    goto :found
)

where AutoHotkey32.exe >nul 2>&1
if %errorlevel%==0 (
    set "AHK_PATH=AutoHotkey32.exe"
    goto :found
)

REM If not found, show error
echo AutoHotkey v2 not found! Please install AutoHotkey v2.
echo Download from: https://www.autohotkey.com/
pause
exit /b 1

:found
cd /d "%~dp0"
echo Starting SmartAutoAction WITH SHIFT + Q with: %AHK_PATH%
start "" "%AHK_PATH%" "%~dp0smartautoaction WITH SHIFT + Q.ahk"
