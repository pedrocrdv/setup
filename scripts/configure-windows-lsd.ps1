$ErrorActionPreference = "Stop"


New-Item `
    -Path "$Env:APPDATA\lsd" `
    -ItemType "Directory" `
    -Force

Copy-Item `
    -Path "$PSScriptRoot\..\resources\lsd\config.yaml" `
    -Destination "$Env:APPDATA\lsd\" `
    -Force
