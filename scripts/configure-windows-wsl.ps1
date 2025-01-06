$ErrorActionPreference = "Stop"


Copy-Item `
    -Path "$PSScriptRoot\..\resources\wsl\.wslconfig" `
    -Destination "$Env:USERPROFILE\" `

Invoke-Expression -Command "wsl --shutdown"

Start-Sleep -Seconds 10
