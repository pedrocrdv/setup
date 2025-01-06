$ErrorActionPreference = "Stop"


Invoke-Expression -Command "wsl --distribution Debian --exec /usr/bin/bash -c 'rm --recursive --force ~/.vscode-server/'"


$PathVisualStudioCode = "/mnt/c/Program\ Files/Microsoft\ VS\ Code/bin/code"

Invoke-Expression -Command "wsl --distribution Debian --exec /usr/bin/bash -c '$PathVisualStudioCode --version'"


$Extensions = Get-Content -Path "$PSScriptRoot\..\resources\vscode\extensions-wsl.txt"

foreach ($Extension in $Extensions) {
    Invoke-Expression "wsl --distribution Debian --exec /usr/bin/bash -c '$PathVisualStudioCode --install-extension $Extension --force'"
}
