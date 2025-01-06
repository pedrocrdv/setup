$ErrorActionPreference = "Stop"


$PathConfigurationFile = "$Env:USERPROFILE\.wslconfig"

Remove-Item `
    -Path $PathConfigurationFile`
    -Force `
    -ErrorAction "SilentlyContinue"

New-Item `
    -ItemType "SymbolicLink" `
    -Path $PathConfigurationFile `
    -Target "$PSScriptRoot\..\resources\wsl\.wslconfig" `
    -Force


Invoke-Expression -Command "wsl --shutdown"

Start-Sleep -Seconds 10
