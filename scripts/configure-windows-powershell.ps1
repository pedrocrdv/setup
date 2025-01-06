$ErrorActionPreference = "Stop"


$PathConfigurationDirectory = Split-Path -Path $PROFILE.CurrentUserAllHosts -Parent
$PathConfigurationFile = Join-Path -Path $PathConfigurationDirectory -ChildPath "profile.ps1"

New-Item `
    -Path $PathConfigurationDirectory `
    -ItemType "Directory" `
    -Force

Remove-Item `
    -Path $PathConfigurationFile `
    -Force `
    -ErrorAction "SilentlyContinue"

New-Item `
    -ItemType "SymbolicLink" `
    -Path $PathConfigurationFile `
    -Target "$PSScriptRoot\..\resources\powershell\profile.ps1" `
    -Force
