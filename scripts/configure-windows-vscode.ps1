$ErrorActionPreference = "Stop"


$COMShell = New-Object -ComObject "WScript.Shell"

$Shortcut = $COMShell.CreateShortcut("$Env:USERPROFILE\Desktop\Visual Studio Code.lnk")

$Shortcut.TargetPath = "C:\Program Files\Microsoft VS Code\Code.exe"
$Shortcut.WorkingDirectory = $Env:USERPROFILE
$Shortcut.WindowStyle = 3
$Shortcut.Description = "Visual Studio Code shortcut"

$Shortcut.Save()


New-Item `
    -Path "$Env:APPDATA\Code\User" `
    -ItemType "Directory" `
    -Force

Copy-Item `
    -Path "$PSScriptRoot\..\resources\vscode\settings.json" `
    -Destination "$Env:APPDATA\Code\User\" `
    -Force

Copy-Item `
    -Path "$PSScriptRoot\..\resources\vscode\keybindings.json" `
    -Destination "$Env:APPDATA\Code\User\" `
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
