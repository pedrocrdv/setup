$ErrorActionPreference = "Stop"


$COMShell = New-Object -ComObject "WScript.Shell"

$Shortcut = $COMShell.CreateShortcut("$Env:USERPROFILE\Desktop\Alacritty.lnk")

$Shortcut.TargetPath = "C:\Program Files\Alacritty\alacritty.exe"
$Shortcut.WorkingDirectory = $Env:USERPROFILE
$Shortcut.WindowStyle = 3
$Shortcut.Description = "Alacritty shortcut"

$Shortcut.Save()


New-Item `
    -Path "$Env:APPDATA\alacritty" `
    -ItemType "Directory" `
    -Force

Copy-Item `
    -Path "$PSScriptRoot\..\resources\alacritty\alacritty.toml" `
    -Destination "$Env:APPDATA\alacritty\" `
    -Force
