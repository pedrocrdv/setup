$ErrorActionPreference = "Stop"


$Bash = "wsl --distribution Debian --exec /usr/bin/bash -c"

$VisualStudioCode = "/mnt/c/Program\ Files/Microsoft\ VS\ Code/bin/code"

$Extensions = Get-Content -Path "$PSScriptRoot\..\resources\vscode\extensions-wsl.txt"

Invoke-Expression -Command "$Bash 'rm --force ~/.vscode-server 2> /dev/null'"

Invoke-Expression -Command "$Bash '$VisualStudioCode --version'"

foreach ($Extension in $Extensions) {
    Invoke-Expression "$Bash '$VisualStudioCode --install-extension $Extension --force'"
}
