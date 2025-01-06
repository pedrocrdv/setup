$ErrorActionPreference = "Stop"


$PathConfigurationDirectory = "$Env:APPDATA\lsd"
$PathConfigurationFile = Join-Path -Path $PathConfigurationDirectory -ChildPath "config.yaml"

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
    -Target "$PSScriptRoot\..\resources\lsd\config.yaml" `
    -Force
