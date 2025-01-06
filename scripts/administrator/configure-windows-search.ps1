$ErrorActionPreference = "Stop"


$PathRegistry = "HKCU:\Software\Policies\Microsoft\Windows\Explorer"

New-Item `
    -Path "HKCU:\Software\Policies\Microsoft\Windows" `
    -Name "Explorer" `
    -Force

New-ItemProperty `
    -Path $PathRegistry `
    -Name "DisableSearchBoxSuggestions" `
    -PropertyType "DWord" `
    -Value 1 `
    -Force

New-ItemProperty `
    -Path $PathRegistry `
    -Name "DisableWebSearch" `
    -PropertyType "DWord" `
    -Value 1 `
    -Force
