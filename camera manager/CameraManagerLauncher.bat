@echo off
REM Camera Manager Launcher
REM By Bibek Chand Sah - Handles UAC Elevation Properly

title Camera Manager

echo.
echo ==========================================
echo Camera Manager
echo By Bibek Chand Sah
echo ==========================================
echo.

REM Check if CameraManager.exe exists in the same directory
if not exist "%~dp0CameraManager.exe" (
    echo Error: CameraManager.exe not found!
    echo Make sure this launcher is in the same folder as CameraManager.exe
    echo.
    pause
    exit /b 1
)

echo Checking system requirements...

REM Check for .NET 9.0 Desktop Runtime
powershell -Command "try { dotnet --list-runtimes | Select-String 'Microsoft.WindowsDesktop.App 9.0' | Out-Null; if ($?) { Write-Host '.NET 9.0 Desktop Runtime: OK' } else { Write-Host '.NET 9.0 Desktop Runtime: MISSING'; exit 1 } } catch { Write-Host '.NET not found. Please install .NET 9.0 Desktop Runtime'; exit 1 }" >nul 2>&1

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ⚠ .NET 9.0 Desktop Runtime is required but not found.
    echo.
    echo Please download and install:
    echo - .NET 9.0 Desktop Runtime ^(x64^)
    echo - Download from: https://dotnet.microsoft.com/download/dotnet/9.0
    echo.
    set /p choice="Press Enter to open download page, or type 'skip' to try anyway: "
    if /i not "%choice%"=="skip" (
        start "" "https://dotnet.microsoft.com/download/dotnet/9.0"
        echo.
        echo After installing .NET, please run this launcher again.
        pause
        exit /b 1
    )
)

echo .NET Runtime: OK
echo.
echo Starting Camera Manager...
echo.
echo IMPORTANT: Administrator Privileges Required
echo ==========================================================
echo * Windows will ask for Administrator permission
echo * Click "Yes" on the UAC prompt
echo * This is required for camera device control
echo * The application will appear in your system tray
echo ==========================================================
echo.

REM Start the application with proper UAC handling
echo Launching Camera Manager with Administrator privileges...
echo Please click "Yes" when Windows asks for permission.
echo.

REM Use PowerShell to start with elevation
powershell -Command "Start-Process '%~dp0CameraManager.exe' -Verb RunAs" 2>nul

if %ERRORLEVEL% EQU 0 (
    echo.
    echo Camera Manager launch initiated!
    echo.
    echo * If you clicked "Yes" on UAC, the app should start shortly
    echo * Look for Camera Manager in your system tray
    echo * If you clicked "No", please run this launcher again
    echo.
    echo This launcher will close in 5 seconds...
    timeout /t 5 /nobreak >nul
) else (
    echo.
    echo Error launching Camera Manager!
    echo.
    echo Possible solutions:
    echo 1. Right-click this launcher and select "Run as Administrator"
    echo 2. Ensure CameraManager.exe is in the same folder
    echo 3. Check Windows Defender/Antivirus settings
    echo 4. Verify .NET 9.0 Desktop Runtime is installed
    echo.
    echo Alternative: Try running CameraManager.exe directly
    echo Right-click CameraManager.exe and "Run as Administrator"
    echo.
    pause
)