$ErrorActionPreference = "Stop"


New-Item `
    -Path "HKCU:Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" `
    -Name "InprocServer32" `
    -Value "" `
    -Force

Stop-Process -ProcessName "explorer" -Force
