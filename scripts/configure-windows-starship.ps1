$ErrorActionPreference = "Stop"


$PathConfigurationDirectory = "$Env:APPDATA\starship"
$PathConfigurationFile = Join-Path -Path $PathConfigurationDirectory -ChildPath "starship.toml"

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
    -Target "$PSScriptRoot\..\resources\starship\starship.toml" `
    -Force
