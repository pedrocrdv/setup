$ErrorActionPreference = "Stop"


New-Item `
    -Path "$Env:APPDATA\starship" `
    -ItemType "Directory" `
    -Force

Copy-Item `
    -Path "$PSScriptRoot\..\resources\starship\starship.toml" `
    -Destination "$Env:APPDATA\starship\" `
    -Force
