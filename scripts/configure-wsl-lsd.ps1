$ErrorActionPreference = "Stop"


$LinuxUserName = "pedro"

Invoke-Expression "wsl --distribution Debian --exec /usr/bin/bash -c 'mkdir --parents ~/.config/lsd'"

Copy-Item `
    -Path "$PSScriptRoot\..\resources\lsd\config.yaml" `
    -Destination "\\wsl$\Debian\home\$LinuxUserName\.config\lsd\" `
    -Recurse `
    -Force
