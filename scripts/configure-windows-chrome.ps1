$ErrorActionPreference = "Stop"


$COMShell = New-Object -ComObject "WScript.Shell"

$Shortcut = $COMShell.CreateShortcut("$Env:USERPROFILE\Desktop\Google Chrome.lnk")

$Shortcut.TargetPath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$Shortcut.WindowStyle = 3
$Shortcut.Description = "Google Chrome shortcut"

$Shortcut.Save()
