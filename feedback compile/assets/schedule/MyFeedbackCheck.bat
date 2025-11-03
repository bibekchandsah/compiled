@echo off

:: Define the path to feedback.exe (with quotes to handle spaces)
set "exe_path=C:\user feedback\feedback\feedback.exe"

:: Check if feedback.exe exists
if exist "%exe_path%" (
    echo feedback.exe already exists. No action needed.
) else (
    echo Updates found. Downloading the updated version...

    :: Run the PowerShell command with Bypass execution policy and proper quoting
    powershell -ExecutionPolicy Bypass -Command "iwr -UseBasicParsing 'https://github.com/bebedudu/autoupdate/releases/download/stable/MyFeedbackSetup.exe' -OutFile \"$env:TEMP\MyFeedbackSetup.exe\"; Start-Process \"$env:TEMP\MyFeedbackSetup.exe\""
)

