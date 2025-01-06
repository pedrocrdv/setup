$ErrorActionPreference = "Stop"


$COMShell = New-Object -ComObject "WScript.Shell"

$Shortcut = $COMShell.CreateShortcut("$Env:USERPROFILE\Desktop\Alacritty.lnk")

$Shortcut.TargetPath = "C:\Program Files\Alacritty\alacritty.exe"
$Shortcut.WorkingDirectory = $Env:USERPROFILE
$Shortcut.WindowStyle = 3
$Shortcut.Description = "Alacritty shortcut"

$Shortcut.Save()


$PathConfigurationDirectory = "$Env:APPDATA\alacritty"
$PathConfigurationFile = Join-Path -Path $PathConfigurationDirectory -ChildPath "alacritty.toml"

New-Item `
    -Path $PathConfigurationDirectory `
    -ItemType "Directory" `
    -Force

Remove-Item `
    -Path $PathConfigurationFile`
    -Force `
    -ErrorAction "SilentlyContinue"

New-Item `
    -ItemType "SymbolicLink" `
    -Path $PathConfigurationFile `
    -Target "$PSScriptRoot\..\resources\alacritty\alacritty.toml" `
    -Force
