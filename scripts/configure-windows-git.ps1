$ErrorActionPreference = "Stop"


$PathConfigurationDirectory = "$Env:APPDATA\git"
$PathConfigurationFile = Join-Path -Path $PathConfigurationDirectory -ChildPath ".gitconfig"

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
    -Target "$PSScriptRoot\..\resources\git\.gitconfig" `
    -Force
