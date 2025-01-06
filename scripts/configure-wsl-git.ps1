$ErrorActionPreference = "Stop"


$LinuxUserName = $Env:USERNAME.ToLower()

Invoke-Expression "wsl --distribution Debian --exec /usr/bin/bash -c 'mkdir --parents ~/.config/git'"

Copy-Item `
    -Path "$PSScriptRoot\..\resources\git\.gitconfig" `
    -Destination "\\wsl$\Debian\home\$LinuxUserName\.config\git\" `
    -Recurse `
    -Force
