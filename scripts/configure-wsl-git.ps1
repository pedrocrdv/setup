$ErrorActionPreference = "Stop"


$LinuxUserName = $Env:USERNAME.ToLower()

Copy-Item `
    -Path "$PSScriptRoot\..\resources\git\.gitconfig" `
    -Destination "\\wsl$\Debian\home\$LinuxUserName\.gitconfig" `
    -Recurse `
    -Force
