[Setup]
AppName=Camera Manager
AppVersion=1.0
AppPublisher=Bibek Chand Sah
AppPublisherURL=
AppSupportURL=
AppUpdatesURL=
DefaultDirName={autopf}\Camera Manager
DefaultGroupName=Camera Manager
AllowNoIcons=yes
LicenseFile=
OutputDir=dist
OutputBaseFilename=CameraManager_Setup_v1.0_by_BibekChandSah
SetupIconFile=camera.ico
Compression=lzma
SolidCompression=yes
WizardStyle=modern
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64
; Important: Do not run the application during installation
RunAfterInstall=no

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 6.1

[Files]
; Application files
Source: "bin\Release\net9.0-windows\publish\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; Launcher script
Source: "LaunchCameraManager.bat"; DestDir: "{app}"; Flags: ignoreversion
; Icon file
Source: "camera.ico"; DestDir: "{app}"; Flags: ignoreversion
; Documentation
Source: "README.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "SOLUTION.md"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
; Create Start Menu shortcut - using the launcher batch file
Name: "{group}\Camera Manager"; Filename: "{app}\LaunchCameraManager.bat"; IconFilename: "{app}\camera.ico"; Comment: "Camera Manager by Bibek Chand Sah"
; Create Desktop shortcut (optional) - using the launcher batch file
Name: "{autodesktop}\Camera Manager"; Filename: "{app}\LaunchCameraManager.bat"; IconFilename: "{app}\camera.ico"; Tasks: desktopicon; Comment: "Camera Manager by Bibek Chand Sah"
; Create Quick Launch shortcut (optional) - using the launcher batch file
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\Camera Manager"; Filename: "{app}\LaunchCameraManager.bat"; IconFilename: "{app}\camera.ico"; Tasks: quicklaunchicon; Comment: "Camera Manager by Bibek Chand Sah"
; Create direct executable shortcut for advanced users
Name: "{group}\Camera Manager (Direct)"; Filename: "{app}\CameraManager.exe"; IconFilename: "{app}\camera.ico"; Comment: "Camera Manager - Direct Launch (Advanced Users)"

[Run]
; Check for .NET and inform user - but don't run the app automatically
Filename: "powershell.exe"; Parameters: "-Command ""& {{try {{ dotnet --list-runtimes | Select-String 'Microsoft.WindowsDesktop.App 9.0' | Out-Null; if ($?) {{ Write-Host '.NET 9.0 Desktop Runtime is installed. You can now run Camera Manager.' }} else {{ Write-Host '.NET 9.0 Desktop Runtime is required. Opening download page...'; Start-Process 'https://dotnet.microsoft.com/download/dotnet/9.0' }} }} catch {{ Write-Host '.NET not found. Opening download page...'; Start-Process 'https://dotnet.microsoft.com/download/dotnet/9.0' }} }}"""; Flags: runhidden; Description: "Check .NET requirements"

[UninstallDelete]
Type: filesandordirs; Name: "{app}"

[Code]
procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then
  begin
    // Show completion message with instructions
    MsgBox('Camera Manager has been installed successfully!' + #13#10 + #13#10 +
           'Important Notes:' + #13#10 +
           '• The application requires .NET 9.0 Desktop Runtime' + #13#10 +
           '• It will request Administrator privileges when started' + #13#10 +
           '• Click "Yes" on the UAC prompt to allow camera control' + #13#10 + #13#10 +
           'You can now launch Camera Manager from:' + #13#10 +
           '• Start Menu > Camera Manager' + #13#10 +
           '• Desktop shortcut (if created)' + #13#10 + #13#10 +
           'Created by: Bibek Chand Sah',
           mbInformation, MB_OK);
  end;
end;