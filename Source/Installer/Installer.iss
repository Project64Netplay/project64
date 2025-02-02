#define BaseDir ExtractFilePath(ExtractFilePath(ExtractFilePath(SourcePath)))
#define AppVersion GetFileVersion(BaseDir + "\Bin\" + Configuration + "\Project64-MPN.exe")

[Setup]
AppId={{BEB5FB69-4080-466F-96C4-F15DF271718B}
AppName=Project64
AppVersion={#AppVersion}
DefaultDirName={pf32}\Project64 MPN
VersionInfoVersion={#AppVersion}
OutputDir={#BaseDir}\Package\
OutputBaseFilename=Setup Project64 MPN
VersionInfoDescription=Installation Setup of Project64 MPN
Compression=lzma2/ultra64
WizardImageFile=Installer-Sidebar.bmp
WizardSmallImageFile=Pj64LogoSmallImage.bmp
DisableProgramGroupPage=yes
DisableReadyPage=yes
Uninstallable=not IsTaskSelected('portablemode')
UninstallDisplayIcon={uninstallexe}
SetupIconFile={#BaseDir}\Source\Project64\UserInterface\Icons\pj64.ico

[Run]
Filename: "{app}\Project64-MPN.exe"; Description: "{cm:LaunchProgram,{#StringChange('Project64', '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[Files]
Source: "{#BaseDir}\Bin\{#Configuration}\Project64-MPN.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#BaseDir}\Config\Video.rdb"; DestDir: "{app}\Config"
Source: "{#BaseDir}\Config\Audio.rdb"; DestDir: "{app}\Config"
Source: "{#BaseDir}\Config\Cheats\*.cht"; DestDir: "{app}\Config\Cheats"
Source: "{#BaseDir}\Config\Enhancements\*.enh"; DestDir: "{app}\Config\Enhancements"
Source: "{#BaseDir}\Config\Project64.rdb"; DestDir: "{app}\Config"
Source: "{#BaseDir}\Config\Project64.rdx"; DestDir: "{app}\Config"
Source: "{#BaseDir}\Lang\*.pj.Lang"; DestDir: "{app}\Lang"
Source: "{#BaseDir}\Plugin\Audio\Jabo_Dsound.dll"; DestDir: "{app}\Plugin\Audio"
Source: "{#BaseDir}\Plugin\Audio\Project64-Audio.dll"; DestDir: "{app}\Plugin\Audio"
Source: "{#BaseDir}\Plugin\GFX\Jabo_Direct3D8.dll"; DestDir: "{app}\Plugin\GFX"
Source: "{#BaseDir}\Plugin\GFX\Project64-Video.dll"; DestDir: "{app}\Plugin\GFX"
Source: "{#BaseDir}\Plugin\GFX\GLideN64\*"; DestDir: "{app}\Plugin\GFX\GLideN64"; Flags: recursesubdirs skipifsourcedoesntexist
Source: "{#BaseDir}\Plugin\Input\PJ64_NRage.dll"; DestDir: "{app}\Plugin\Input"
Source: "{#BaseDir}\Plugin\Input\Project64-Input.dll"; DestDir: "{app}\Plugin\Input"
Source: "{#BaseDir}\Plugin\Input\netplay_input_plugin.dll"; DestDir: "{app}\Plugin\Input"
Source: "{#BaseDir}\Plugin\RSP\RSP 1.7.dll"; DestDir: "{app}\Plugin\RSP"
Source: "{#BaseDir}\Replace.bat"; DestDir: "{app}\Replace.bat"
Source: "{#BaseDir}\Save\*.eep"; DestDir: "{app}\Save"
Source: "{#BaseDir}\Save\*.sra"; DestDir: "{app}\Save"
Source: "{#BaseDir}\Save\Backup\*.eep"; DestDir: "{app}\Save\Backup"
Source: "{#BaseDir}\Save\Backup\*.sra"; DestDir: "{app}\Save\Backup"

[Dirs]
Name: "{app}\Config"; Permissions: everyone-full
Name: "{app}\Config\Cheats-User"; Permissions: everyone-full
Name: "{app}\Logs"; Permissions: everyone-full
Name: "{app}\Save"; Permissions: everyone-full
Name: "{app}\Save"; Permissions: everyone-full
Name: "{app}\Screenshots"; Permissions: everyone-full
Name: "{app}\Textures"; Permissions: everyone-full
Name: "{app}\Plugin\GFX\GLideN64"; Permissions: everyone-full

[Icons]
Name: "{commondesktop}\Project64"; Filename: "{app}\Project64-MPN.exe"; Tasks: desktopicon
Name: "{commonprograms}\Project64 MPN\Project64"; Filename: "{app}\Project64-MPN.exe"
Name: "{commonprograms}\Project64 MPN\Uninstall Project64 MPN"; Filename: "{uninstallexe}"; Parameters: "/LOG"; Flags: createonlyiffileexists
Name: "{commonprograms}\Project64 MPN\Support"; Filename: "http://forum.pj64-emu.com"

[Tasks]
Name: desktopicon; Description: "Create a &desktop icon"
Name: portablemode; Description: "&Portable Mode"; Flags: unchecked
