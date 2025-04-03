$ErrorActionPreference = "Stop"


$PathConfigurationDirectory = "$Env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\"

New-Item `
    -Path $PathConfigurationDirectory `
    -ItemType "Directory" `
    -Force

Copy-Item `
    -Path "$PSScriptRoot\..\resources\terminal\settings.json" `
    -Destination $PathConfigurationDirectory  `
    -Force
