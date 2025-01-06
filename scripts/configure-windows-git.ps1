$ErrorActionPreference = "Stop"


New-Item `
    -Path "$Env:APPDATA\git" `
    -ItemType "Directory" `
    -Force

Copy-Item `
    -Path "$PSScriptRoot\..\resources\git\.gitconfig" `
    -Destination "$Env:APPDATA\git\" `
    -Force
