@echo off
setlocal enabledelayedexpansion

set "SCRIPT_DIR=%~dp0"

:menu_loop
REM Clear screen
cls

REM Check what's actually running
call :check_running

REM Show menu using PowerShell for colors
powershell -Command "Write-Host 'Commands are shown like this' -NoNewline; Write-Host '[' -ForegroundColor White -NoNewline; Write-Host '#' -ForegroundColor Green -NoNewline; Write-Host ']' -ForegroundColor White"
echo.

REM Show status if something is running
if "%RUNNING_VERSION%"=="regular" (
    echo ENABLED:
    powershell -Command "Write-Host 'smartautoaction is ' -NoNewline; Write-Host 'ON' -ForegroundColor Green"
    echo.
)
if "%RUNNING_VERSION%"=="shift" (
    echo ENABLED:
    powershell -Command "Write-Host 'smartautoaction WITH SHIFT + Q is ' -NoNewline; Write-Host 'ON' -ForegroundColor Green"
    echo.
)
powershell -Command "Write-Host '[' -ForegroundColor White -NoNewline; Write-Host '1' -ForegroundColor Green -NoNewline; Write-Host ']' -ForegroundColor White -NoNewline; Write-Host ' SmartAutoAction'"
powershell -Command "Write-Host '[' -ForegroundColor White -NoNewline; Write-Host '2' -ForegroundColor Green -NoNewline; Write-Host ']' -ForegroundColor White -NoNewline; Write-Host ' SmartAutoAction WITH SHIFT + Q'"
powershell -Command "Write-Host '[' -ForegroundColor White -NoNewline; Write-Host '3' -ForegroundColor Green -NoNewline; Write-Host ']' -ForegroundColor White -NoNewline; Write-Host ' Turn Off'"
echo.
set /p "choice=Enter Command: "

REM Handle choice
if "%choice%"=="1" goto :start_regular
if "%choice%"=="2" goto :start_shift
if "%choice%"=="3" goto :turn_off
goto :menu_loop

:start_regular
REM Stop any running AutoHotkey scripts first
call :stop_all
timeout /t 1 /nobreak >nul
call "%SCRIPT_DIR%run_smartautoaction.bat"
timeout /t 1 /nobreak >nul
goto :menu_loop

:start_shift
REM Stop any running AutoHotkey scripts first
call :stop_all
timeout /t 1 /nobreak >nul
call "%SCRIPT_DIR%run_smartautoaction_WITH_SHIFT_Q.bat"
timeout /t 1 /nobreak >nul
goto :menu_loop

:turn_off
call :stop_all
echo.
echo All versions stopped.
timeout /t 1 /nobreak >nul
goto :menu_loop

:check_running
REM Check what's actually running - verify process exists
set "RUNNING_VERSION="

REM Check for shift version first (more specific)
for /f "skip=1 tokens=1" %%a in ('wmic process where "name='AutoHotkey64.exe' or name='AutoHotkey32.exe'" get processid 2^>nul') do (
    REM Verify process exists
    tasklist /FI "PID eq %%a" 2>nul | findstr /C:"%%a" >nul 2>&1
    if !errorlevel!==0 (
        REM Get commandline for this process
        for /f "tokens=*" %%b in ('wmic process where "processid=%%a" get commandline 2^>nul') do (
            REM Check if it contains the shift script name
            echo %%b | findstr /C:"WITH SHIFT + Q.ahk" >nul 2>&1
            if !errorlevel!==0 (
                set "RUNNING_VERSION=shift"
                goto :check_done
            )
        )
    )
)

REM Check for regular version only if shift not found
if "%RUNNING_VERSION%"=="" (
    for /f "skip=1 tokens=1" %%a in ('wmic process where "name='AutoHotkey64.exe' or name='AutoHotkey32.exe'" get processid 2^>nul') do (
        REM Verify process exists
        tasklist /FI "PID eq %%a" 2>nul | findstr /C:"%%a" >nul 2>&1
        if !errorlevel!==0 (
            REM Get commandline for this process
            for /f "tokens=*" %%b in ('wmic process where "processid=%%a" get commandline 2^>nul') do (
                REM Must contain smartautoaction.ahk but NOT "WITH SHIFT"
                echo %%b | findstr /C:"smartautoaction.ahk" >nul 2>&1
                if !errorlevel!==0 (
                    echo %%b | findstr /C:"WITH SHIFT" >nul 2>&1
                    if !errorlevel!==1 (
                        set "RUNNING_VERSION=regular"
                        goto :check_done
                    )
                )
            )
        )
    )
)

:check_done
exit /b

:stop_all
REM Kill all AutoHotkey processes running smartautoaction scripts
for /f "skip=1 tokens=1" %%a in ('wmic process where "name='AutoHotkey64.exe' or name='AutoHotkey32.exe'" get processid 2^>nul') do (
    for /f "tokens=*" %%b in ('wmic process where "processid=%%a" get commandline 2^>nul') do (
        echo %%b | findstr /C:"smartautoaction" >nul 2>&1
        if !errorlevel!==0 (
            taskkill /PID %%a /F >nul 2>&1
        )
    )
)
exit /b

