@echo off
setlocal enabledelayedexpansion

set "SCRIPT_DIR=%~dp0"

:menu_loop
REM Clear screen
cls

REM Check what's actually running
call :check_running

REM Show status header with bright green
powershell -Command "Write-Host '====================' -ForegroundColor Green"
powershell -Command "Write-Host '  SMARTAUTOACTION' -ForegroundColor Green"
powershell -Command "Write-Host '   by landn.thrn' -ForegroundColor Green"
powershell -Command "Write-Host '====================' -ForegroundColor Green"
echo.

REM Show status if something is running
if "%RUNNING_VERSION%"=="regular" (
    powershell -Command "Write-Host 'STATUS:' -ForegroundColor Green -NoNewline; Write-Host ' F1 Only version is ACTIVE' -ForegroundColor White"
    echo.
)
if "%RUNNING_VERSION%"=="shiftq" (
    powershell -Command "Write-Host 'STATUS:' -ForegroundColor Green -NoNewline; Write-Host ' Shift + Q version is ACTIVE' -ForegroundColor White"
    echo.
)
if "%RUNNING_VERSION%"=="" (
    powershell -Command "Write-Host 'STATUS:' -ForegroundColor Green -NoNewline; Write-Host ' No script is active' -ForegroundColor White"
    echo.
)

REM Menu options with bright green brackets
powershell -Command "Write-Host '[' -ForegroundColor Green -NoNewline; Write-Host '1' -ForegroundColor White -NoNewline; Write-Host ']' -ForegroundColor Green -NoNewline; Write-Host ' Start Shift + Q Version (Shift + Q & F1 + any key)' -ForegroundColor White"
powershell -Command "Write-Host '[' -ForegroundColor Green -NoNewline; Write-Host '2' -ForegroundColor White -NoNewline; Write-Host ']' -ForegroundColor Green -NoNewline; Write-Host ' Start F1 Only Version (F1 + any key)' -ForegroundColor White"
powershell -Command "Write-Host '[' -ForegroundColor Green -NoNewline; Write-Host '3' -ForegroundColor White -NoNewline; Write-Host ']' -ForegroundColor Green -NoNewline; Write-Host ' Turn Off' -ForegroundColor White"
powershell -Command "Write-Host '[' -ForegroundColor Green -NoNewline; Write-Host '4' -ForegroundColor White -NoNewline; Write-Host ']' -ForegroundColor Green -NoNewline; Write-Host ' Info' -ForegroundColor White"
powershell -Command "Write-Host '[' -ForegroundColor Green -NoNewline; Write-Host 'Q' -ForegroundColor White -NoNewline; Write-Host ']' -ForegroundColor Green -NoNewline; Write-Host ' Quit' -ForegroundColor White"
echo.

set /p "choice=Enter choice: "

REM Handle choice
if "%choice%"=="1" goto :start_shiftq
if "%choice%"=="2" goto :start_regular
if "%choice%"=="3" goto :turn_off
if "%choice%"=="4" goto :show_info
if /i "%choice%"=="q" goto :quit
goto :menu_loop

:start_regular
REM Stop any running AutoHotkey scripts first
call :stop_all
timeout /t 1 /nobreak >nul
powershell -Command "Write-Host 'Starting F1 Only Version...' -ForegroundColor Green"
call "%SCRIPT_DIR%launcher.bat" regular
timeout /t 1 /nobreak >nul
goto :menu_loop

:start_shiftq
REM Stop any running AutoHotkey scripts first
call :stop_all
timeout /t 1 /nobreak >nul
powershell -Command "Write-Host 'Starting Shift + Q Version...' -ForegroundColor Green"
call "%SCRIPT_DIR%launcher.bat" shiftq
timeout /t 1 /nobreak >nul
goto :menu_loop

:turn_off
call :stop_all
powershell -Command "Write-Host 'Script has perished' -ForegroundColor White"
timeout /t 1 /nobreak >nul
goto :menu_loop

:show_info
cls

REM Display embedded info content with proper colors
powershell -Command "Write-Host '====================' -ForegroundColor Green"
powershell -Command "Write-Host '  SMARTAUTOACTION' -ForegroundColor Green"
powershell -Command "Write-Host '   by landn.thrn' -ForegroundColor Green"
powershell -Command "Write-Host '====================' -ForegroundColor Green"
echo.
powershell -Command "Write-Host 'COMPARISONS BETWEEN THE F1 ONLY VERSION & THE SHIFT + Q VERSION:' -ForegroundColor Green"
echo.
powershell -Command "Write-Host '~~~~~~~~~~~~~~~~~~' -ForegroundColor White"
echo.
powershell -Command "Write-Host 'DIFFERENCE IN USE:' -ForegroundColor Green"
powershell -Command "Write-Host 'For both versions you can automate any other key/action continuously, use' -ForegroundColor White"
powershell -Command "Write-Host 'F1 + (any key other than W, + mouse clicks & buttons)' -ForegroundColor White"
echo.
powershell -Command "Write-Host 'As for autorun there''s two slightly different versions:' -ForegroundColor White"
echo.
powershell -Command "Write-Host '- If you''re using the Shift + Q version you can autorun with Shift + Q or F1 + W' -ForegroundColor White"
echo.
powershell -Command "Write-Host '- If you''re using the F1 ONLY VERSION then you autorun with just F1 + W' -ForegroundColor White"
echo.
powershell -Command "Write-Host '*The Shift + Q Version is obviously more convenient for games*' -ForegroundColor White"
echo.
powershell -Command "Write-Host '~~~~~~~~~~~~~~~~~~' -ForegroundColor White"
echo.
powershell -Command "Write-Host 'DIFFERENCE IN CANCELING:' -ForegroundColor Green"
powershell -Command "Write-Host 'The autorun keybinds Shift + Q or F1 + W work differently than' -ForegroundColor White"
powershell -Command "Write-Host 'F1 + (any key other than W + mouse clicks & buttons):' -ForegroundColor White"
echo.
powershell -Command "Write-Host '1. Using Shift + Q or F1 + W won''t be canceled by these keys:' -ForegroundColor White"
powershell -Command "Write-Host '   Control, Shift, Caps, Tab, Esc, Alt, A, D, E, F, W, Space, Mouse clicks' -ForegroundColor White"
echo.
powershell -Command "Write-Host '   They''ll be canceled by any other keys (Using ''S'' to cancel is most convenient)' -ForegroundColor White"
echo.
powershell -Command "Write-Host '2. Using F1 + (any key other than W + mouse clicks & buttons) will be canceled by any other key press' -ForegroundColor White"
echo.
powershell -Command "Write-Host 'That''s the difference' -ForegroundColor White"
echo.
powershell -Command "Write-Host '*Autorun is configured to auto sprint, not auto walk of course*' -ForegroundColor White"
echo.
powershell -Command "Write-Host '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~' -ForegroundColor White"
echo.
powershell -Command "Write-Host 'EXAMPLE OF HOW IT''S SMARTER THAN A REGULAR AUTORUN .AHK' -ForegroundColor Green"
echo.
powershell -Command "Write-Host 'Say you''re breaking down a tree in a survival game, you would use:' -ForegroundColor White"
powershell -Command "Write-Host 'F1 + Left Mouse Click' -ForegroundColor White"
echo.
powershell -Command "Write-Host 'You will automatically keep hitting the tree' -ForegroundColor White"
echo.
powershell -Command "Write-Host '~~~~~~~~~~~~~~~~~~' -ForegroundColor White"
echo.
powershell -Command "Write-Host 'Lots of tree logs and sticks fall on the ground:' -ForegroundColor White"
powershell -Command "Write-Host 'F1 + (whatever the interact/pickup button is in your game)' -ForegroundColor White"
echo.
powershell -Command "Write-Host 'You will auto pick up the logs and sticks you''re looking at' -ForegroundColor White"
echo.
powershell -Command "Write-Host '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~' -ForegroundColor White"
echo.
powershell -Command "Write-Host 'Press any key to go back to menu . . .' -ForegroundColor Green"

pause >nul
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
    REM If we get here, it's F1 Only mode
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
