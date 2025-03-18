$ErrorActionPreference = "Stop"


$PathConfigurationFile = "$Env:USERPROFILE\.gitconfig"

Remove-Item `
    -Path $PathConfigurationFile `
    -Force `
    -ErrorAction "SilentlyContinue"

New-Item `
    -ItemType "SymbolicLink" `
    -Path $PathConfigurationFile `
    -Target "$PSScriptRoot\..\resources\git\.gitconfig" `
    -Force
