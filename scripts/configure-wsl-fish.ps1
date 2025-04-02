$ErrorActionPreference = "Stop"


$LinuxUserName = "pedro"

Invoke-Expression "wsl --distribution Debian --exec /usr/bin/bash -c 'mkdir --parents ~/.config/fish'"

Invoke-Expression "wsl --distribution Debian --exec /usr/bin/bash -c 'rm --recursive ~/.config/fish/*'"

Copy-Item `
    -Path "$PSScriptRoot\..\resources\fish\*" `
    -Destination "\\wsl$\Debian\home\$LinuxUserName\.config\fish\" `
    -Recurse `
    -Force


Invoke-Expression -Command "wsl --distribution Debian --exec /usr/bin/bash -c 'mkdir ~/.config/fish/completions'"

$Command = "/home/linuxbrew/.linuxbrew/bin/uv generate-shell-completion fish > ~/.config/fish/completions/uv.fish"

Invoke-Expression -Command "wsl --distribution Debian --exec /usr/bin/bash -c '$Command'"
