$ErrorActionPreference = "Stop"


$ProfileDirectory = Split-Path -Path $PROFILE.CurrentUserAllHosts -Parent

New-Item -Path $ProfileDirectory -ItemType "Directory" -Force

Copy-Item `
    -Path "$PSScriptRoot\..\resources\powershell\profile.ps1" `
    -Destination $PROFILE.CurrentUserAllHosts `
    -Force
