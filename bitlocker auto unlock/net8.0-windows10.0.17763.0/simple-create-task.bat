@echo off
title BitLocker Auto Unlock - Task Creation
color 0A

echo =====================================
echo BitLocker Auto Unlock - Task Creation
echo =====================================
echo.

REM Get the directory where this batch file is located
set "SCRIPT_DIR=%~dp0"
set "EXE_PATH=%SCRIPT_DIR%BitLockerManager.exe"

echo Script Directory: %SCRIPT_DIR%
echo Executable Path: %EXE_PATH%
echo.

REM Check if executable exists
if not exist "%EXE_PATH%" (
    echo ERROR: BitLockerManager.exe not found!
    echo Make sure this batch file is in the same folder as BitLockerManager.exe
    echo.
    pause
    exit /b 1
)

echo Found BitLockerManager.exe
echo.

REM Remove existing task (ignore errors)
echo Removing existing task if it exists...
schtasks /delete /tn "BitLocker Auto Unlock" /f >nul 2>&1
if %errorlevel% equ 0 (
    echo Existing task removed
) else (
    echo No existing task found
)
echo.

REM Create new task
echo Creating new startup task...
schtasks /create /tn "BitLocker Auto Unlock" /tr "\"%EXE_PATH%\"" /sc onlogon /delay 0000:30 /rl highest /f

if %errorlevel% equ 0 (
    echo.
    echo SUCCESS: Task created successfully!
    echo BitLocker Manager will start automatically when you log in
    echo.
    
    REM Show task details
    echo Task Details:
    echo -------------
    schtasks /query /tn "BitLocker Auto Unlock" /fo list | findstr /i "TaskName State Next"
    
) else (
    echo.
    echo ERROR: Failed to create task
    echo This might be due to insufficient permissions
    echo Try running this batch file as Administrator
    echo.
)

echo.
echo Press any key to exit...
pause >nul