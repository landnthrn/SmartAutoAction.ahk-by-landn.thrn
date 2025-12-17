@echo off
setlocal enabledelayedexpansion

set "SCRIPT_DIR=%~dp0"

:menu_loop
REM Clear screen
cls

REM Check what's actually running
call :check_running

REM Show status header with bright green
powershell -Command "Write-Host 'SMARTAUTOACTION' -ForegroundColor Green"
powershell -Command "Write-Host '================' -ForegroundColor Green"
echo.

REM Show status if something is running
if "%RUNNING_VERSION%"=="regular" (
    powershell -Command "Write-Host 'STATUS:' -ForegroundColor Green -NoNewline; Write-Host ' Regular version is ACTIVE' -ForegroundColor White"
    echo.
)
if "%RUNNING_VERSION%"=="shiftq" (
    powershell -Command "Write-Host 'STATUS:' -ForegroundColor Green -NoNewline; Write-Host ' Shift+Q version is ACTIVE' -ForegroundColor White"
    echo.
)
if "%RUNNING_VERSION%"=="" (
    powershell -Command "Write-Host 'STATUS:' -ForegroundColor Green -NoNewline; Write-Host ' No version active' -ForegroundColor White"
    echo.
)

REM Menu options with bright green brackets
powershell -Command "Write-Host '[' -ForegroundColor Green -NoNewline; Write-Host '1' -ForegroundColor White -NoNewline; Write-Host ']' -ForegroundColor Green -NoNewline; Write-Host ' Start Regular Version (F1 + key)' -ForegroundColor White"
powershell -Command "Write-Host '[' -ForegroundColor Green -NoNewline; Write-Host '2' -ForegroundColor White -NoNewline; Write-Host ']' -ForegroundColor Green -NoNewline; Write-Host ' Start Shift+Q Version (F1 + key + Shift+Q)' -ForegroundColor White"
powershell -Command "Write-Host '[' -ForegroundColor Green -NoNewline; Write-Host '3' -ForegroundColor White -NoNewline; Write-Host ']' -ForegroundColor Green -NoNewline; Write-Host ' Turn Off' -ForegroundColor White"
powershell -Command "Write-Host '[' -ForegroundColor Green -NoNewline; Write-Host 'Q' -ForegroundColor White -NoNewline; Write-Host ']' -ForegroundColor Green -NoNewline; Write-Host ' Quit' -ForegroundColor White"
echo.

set /p "choice=Enter choice: "

REM Handle choice
if "%choice%"=="1" goto :start_regular
if "%choice%"=="2" goto :start_shiftq
if "%choice%"=="3" goto :turn_off
if /i "%choice%"=="q" goto :quit
goto :menu_loop

:start_regular
REM Stop any running AutoHotkey scripts first
call :stop_all
timeout /t 1 /nobreak >nul
powershell -Command "Write-Host 'Starting Regular Version...' -ForegroundColor Green"
call "%SCRIPT_DIR%launcher.bat" regular
timeout /t 1 /nobreak >nul
goto :menu_loop

:start_shiftq
REM Stop any running AutoHotkey scripts first
call :stop_all
timeout /t 1 /nobreak >nul
powershell -Command "Write-Host 'Starting Shift+Q Version...' -ForegroundColor Green"
call "%SCRIPT_DIR%launcher.bat" shiftq
timeout /t 1 /nobreak >nul
goto :menu_loop

:turn_off
call :stop_all
powershell -Command "Write-Host 'Script has perished' -ForegroundColor White"
timeout /t 1 /nobreak >nul
goto :menu_loop

:quit
powershell -Command "Write-Host 'Goodbye!' -ForegroundColor Green"
goto :end

:check_running
REM Check what's actually running
set "RUNNING_VERSION="

REM Check if any AutoHotkey process is running
tasklist /FI "IMAGENAME eq AutoHotkey64.exe" 2>nul | find /I "AutoHotkey64.exe" >nul
if %errorlevel%==0 (
    REM AutoHotkey is running, check command line to determine version
    for /f "skip=1 tokens=1" %%a in ('wmic process where "name='AutoHotkey64.exe'" get processid 2^>nul') do (
        for /f "tokens=*" %%b in ('wmic process where "processid=%%a" get commandline 2^>nul') do (
            echo %%b | findstr /C:"smartautoaction_shiftq.ahk" >nul 2>&1
            if !errorlevel!==0 (
                set "RUNNING_VERSION=shiftq"
                goto :check_done
            )
        )
    )
    REM If we get here, it's regular mode
    set "RUNNING_VERSION=regular"
)

:check_done
exit /b

:stop_all
REM Kill ALL AutoHotkey processes
taskkill /IM AutoHotkey64.exe /F >nul 2>&1
taskkill /IM AutoHotkey32.exe /F >nul 2>&1

exit /b

:end
