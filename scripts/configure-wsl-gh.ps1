$ErrorActionPreference = "Stop"


$Command = 'export BROWSER="/mnt/c/Program\ Files/Google/Chrome/Application/chrome.exe" && gh auth login --git-protocol=https --hostname=github.com --web'

Invoke-Expression "wsl --distribution Debian --exec /usr/bin/bash -c '$Command'"
