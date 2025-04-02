$ErrorActionPreference = "Stop"


$LinuxUserName = "pedro"

$FileContent = Get-Content "$PSScriptRoot\..\resources\wsl\wsl.conf" -Raw

$Command = @"
wsl --distribution Debian --user $LinuxUserName --exec /usr/bin/bash -c 'sudo tee /etc/wsl.conf <<< "$FileContent"'
"@

Invoke-Expression -Command $Command


Invoke-Expression -Command "wsl --shutdown"

Start-Sleep -Seconds 10
