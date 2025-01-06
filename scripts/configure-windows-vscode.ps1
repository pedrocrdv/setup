$ErrorActionPreference = "Stop"


$COMShell = New-Object -ComObject "WScript.Shell"

$Shortcut = $COMShell.CreateShortcut("$Env:USERPROFILE\Desktop\Visual Studio Code.lnk")

$Shortcut.TargetPath = "C:\Program Files\Microsoft VS Code\Code.exe"
$Shortcut.WorkingDirectory = $Env:USERPROFILE
$Shortcut.WindowStyle = 3
$Shortcut.Description = "Visual Studio Code shortcut"

$Shortcut.Save()


$PathConfigurationDirectory = "$Env:APPDATA\Code\User\"
$PathConfigurationFile = Join-Path -Path $PathConfigurationDirectory -ChildPath "settings.json"
$PathKeybindingsFile = Join-Path -Path $PathConfigurationDirectory -ChildPath "keybindings.json"

New-Item `
    -Path $PathConfigurationDirectory `
    -ItemType "Directory" `
    -Force

Remove-Item `
    -Path $PathConfigurationFile `
    -Force `
    -ErrorAction "SilentlyContinue"

Remove-Item `
    -Path $PathKeybindingsFile `
    -Force `
    -ErrorAction "SilentlyContinue"

New-Item `
    -ItemType "SymbolicLink" `
    -Path $PathConfigurationFile `
    -Target "$PSScriptRoot\..\resources\vscode\settings.json" `
    -Force

New-Item `
    -ItemType "SymbolicLink" `
    -Path $PathKeybindingsFile `
    -Target "$PSScriptRoot\..\resources\vscode\keybindings.json" `
    -Force


Remove-Item `
    -Path "$Env:USERPROFILE\.vscode" `
    -Recurse `
    -Force `
    -ErrorAction "SilentlyContinue"

$Extensions = Get-Content -Path "$PSScriptRoot\..\resources\vscode\extensions-windows.txt"

foreach ($Extension in $Extensions) {
    Invoke-Expression "code --install-extension $Extension --force"
}
