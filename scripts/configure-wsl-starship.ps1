$ErrorActionPreference = "Stop"


$LinuxUserName = "pedro"

Invoke-Expression "wsl --distribution Debian --exec /usr/bin/bash -c 'mkdir ~/.config 2> /dev/null'"

Copy-Item `
    -Path "$PSScriptRoot\..\resources\starship\starship.toml" `
    -Destination "\\wsl$\Debian\home\$LinuxUserName\.config\" `
    -Force
