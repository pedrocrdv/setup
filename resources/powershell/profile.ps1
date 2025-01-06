function Enter-WSLDebian {
    param (
        [Parameter(Mandatory = $false)]
        [string]$ShellPath = "/usr/bin/bash"
    )

    $Arguments = @("--distribution", "Debian")

    if ($PWD.Path -eq $Env:USERPROFILE) {
        $Arguments += @("--cd", "~")
    }

    $Arguments += @("--exec", $ShellPath)

    & "wsl" $Arguments
}

function Enter-WSLDebianFish {
    Enter-WSLDebian -ShellPath "/usr/bin/fish"
}

function Get-ImAdministrator {
    $WindowsIdentity = [Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()
    $WindowsAdministratorRole = [Security.Principal.WindowsBuiltInRole]::Administrator

    if ($WindowsIdentity.IsInRole($WindowsAdministratorRole)) {
        Write-Host "You are running as administrator" -ForegroundColor "Green"
    }
    else {
        Write-Host "You are not running as administrator" -ForegroundColor "Red"
    }
}

function Get-IPAddress {
    param (
        [Parameter(Mandatory = $false)]
        [string]$Uri = "http://ipinfo.io/ip"
    )
    try {
        $ResponseContent = Invoke-WebRequest -Uri $Uri | Select-Object -ExpandProperty "Content"
        $IPAddress = $ResponseContent.Trim()
        return $IPAddress
    }
    catch {
        Write-Host "Failed to fetch the IP address" -ForegroundColor "Red"
    }
}

function Set-ClipboardToIPAddress {
    try {
        $IPAddress = Get-IPAddress
        Set-Clipboard -Value $IPAddress
        Write-Host "$IPAddress has been copied to the clipboard" -ForegroundColor "Green"
    }
    catch {
        Write-Host "Failed to copy the IP address" -ForegroundColor "Red"
    }
}

function Invoke-LSDeluxe {
    param (
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$Arguments
    )

    $DefaultArguments = @(
        "--depth=1"
        "--long"
        "--permission=disable"
        "--tree"
    )

    & "lsd" $DefaultArguments $Arguments
}

function Invoke-Starship {
    param (
        [Parameter(Mandatory = $false)]
        [string]$PathConfig
    )

    if ($PathConfig) {
        if (Test-Path -Path $PathConfig) {
            $Env:STARSHIP_CONFIG = $PathConfig
        }
        else {
            Write-Host "$PathConfig was not found" -ForegroundColor "Red"
        }
    }

    & "starship" @("init", "powershell", "--print-full-init") | Out-String | Invoke-Expression
}

function Get-PathEntries {
    return $Env:PATH -split ";" | Where-Object { $_.Trim() -ne "" }
}

function Remove-Junk {
    $JunkItems = @(
        "$Env:LOCALAPPDATA\Activision\bootstrapper\crash_reports"
        "$Env:LOCALAPPDATA\Activision\Call of Duty\crash_reports"
        "$Env:LOCALAPPDATA\cache"
        "$Env:LOCALAPPDATA\CEF"
        "$Env:LOCALAPPDATA\Comms"
        "$Env:LOCALAPPDATA\ConnectedDevicesPlatform"
        "$Env:LOCALAPPDATA\D3DSCache"
        "$Env:LOCALAPPDATA\IconCache.db"
        "$Env:LOCALAPPDATA\PeerDistRepub"
        "$Env:LOCALAPPDATA\PlaceholderTileLogoFolder"
        "$Env:LOCALAPPDATA\Programs"
        "$Env:LOCALAPPDATA\Publishers"
        "$Env:LOCALAPPDATA\VirtualStore"
        "$Env:USERPROFILE\.cache"
        "$Env:USERPROFILE\Documents\Custom Office Templates"
        "$Env:USERPROFILE\Microsoft"
        "$Env:USERPROFILE\Saved Games"
        "$Env:USERPROFILE\vscode-remote-wsl"
    )

    $JunkDirectoriesItems = @(
        "$Env:LOCALAPPDATA\Microsoft\Windows\WER\"
        "$Env:LOCALAPPDATA\Temp\"
        "$Env:USERPROFILE\Downloads\"
        "$Env:USERPROFILE\Music\"
        "$Env:USERPROFILE\Pictures\"
        "$Env:USERPROFILE\Videos\"
    ) | Get-ChildItem -ErrorAction "SilentlyContinue"

    $CacheAndLogsDirectories = @(
        "$Env:LOCALAPPDATA\Battle.net\"
        "$Env:LOCALAPPDATA\EADesktop\"
        "$Env:LOCALAPPDATA\EALaunchHelper\"
        "$Env:LOCALAPPDATA\Electronic Arts\"
        "$Env:LOCALAPPDATA\Microsoft\OneDrive\"
        "$Env:LOCALAPPDATA\Microsoft\Teams\"
        "$Env:LOCALAPPDATA\Origin\"
        "$Env:LOCALAPPDATA\Steam\"
    ) | Get-ChildItem -Recurse -Directory -ErrorAction "SilentlyContinue" | Where-Object { $_.Name -match 'cache|log' }

    $Items = $JunkItems + $JunkDirectoriesItems + $CacheAndLogsDirectories

    foreach ($Item in $Items) {
        if (Test-Path -Path $Item) {
            Remove-Item -Path $Item -Recurse -Force -ErrorAction "SilentlyContinue"

            if (Test-Path -Path $Item) {
                Write-Host "Failed to remove $Item" -ForegroundColor "Red"
            }
            else {
                Write-Host "Removed $Item" -ForegroundColor "Green"
            }
        }
    }
}

function Start-AlacrittyPowerShellAsAdministrator {
    Start-Process `
        -FilePath "cmd" `
        -ArgumentList '/c start "" "alacritty" --title "Alacritty (Administrator)"' `
        -Verb "RunAs"
}

function Start-MouseMovement {
    param (
        [Parameter(Mandatory = $false)]
        [int]$IntervalSeconds = 5,

        [Parameter(Mandatory = $false)]
        [int]$ScreenPixelsWidth = 1920,

        [Parameter(Mandatory = $false)]
        [int]$ScreenPixelsHeight = 1080
    )

    $ScreenCenterX = [math]::Floor($ScreenPixelsWidth / 2)
    $ScreenCenterY = [math]::Floor($ScreenPixelsHeight / 2)

    $MovementDistanceX = [math]::Floor($ScreenPixelsWidth / 20)

    $Mouse = Add-Type `
        -Name "Mouse" `
        -PassThru `
        -MemberDefinition '[DllImport("user32.dll")] public static extern void SetCursorPos(int X, int Y);'

    while ($true) {
        $Mouse::SetCursorPos($ScreenCenterX - $MovementDistanceX, $ScreenCenterY)
        Start-Sleep -Milliseconds 500
        $Mouse::SetCursorPos($ScreenCenterX + $MovementDistanceX, $ScreenCenterY)

        Start-Sleep -Seconds $IntervalSeconds
    }
}


Set-Alias -Name "c" -Value Clear-Host
Set-Alias -Name "deb" -Value Enter-WSLDebianFish
Set-Alias -Name "ip" -Value Set-ClipboardToIPAddress
Set-Alias -Name "isudo" -Value Get-ImAdministrator
Set-Alias -Name "junk" -Value Remove-Junk
Set-Alias -Name "ll" -Value Invoke-LSDeluxe
Set-Alias -Name "mouse" -Value Start-MouseMovement
Set-Alias -Name "pp" -Value Get-PathEntries
Set-Alias -Name "sudo" -Value Start-AlacrittyPowerShellAsAdministrator


if (Get-Module -Name "PSReadLine") {
    Set-PSReadLineOption -Colors @{
        Command          = "`e[97m" # ANSI white bright
        Comment          = "`e[2;32m" # ANSI green dimmed
        Default          = "`e[97m" # ANSI white bright
        Error            = "`e[91m" # ANSI red bright
        InlinePrediction = "`e[2;37m" # ANSI white dimmed
        Keyword          = "`e[95m" # ANSI magenta bright
        Member           = "`e[97m" # ANSI white bright
        Number           = "`e[92m" # ANSI green bright
        Operator         = "`e[97m" # ANSI white bright
        Parameter        = "`e[97m" # ANSI white bright
        String           = "`e[93m" # ANSI yellow bright
        Type             = "`e[97m" # ANSI white bright
        Variable         = "`e[96m" # ANSI cyan bright
    }
}
else {
    Write-Host "PSReadLine was not found" -BackgroundColor "Red"
}

$Env:LS_COLORS = "bd=97:cd=97:di=97:ex=97:fi=97:ln=97:mi=97:or=97:ow=97:pi=97:sg=97:so=97:st=97:su=97:tw=97"


if (Test-Path -Path "$Env:APPDATA\git\.gitconfig") {
    $Env:GIT_CONFIG_GLOBAL = "$Env:APPDATA\git\.gitconfig"
}


if (Test-Path -Path "$Env:APPDATA\starship\") {
    $Env:STARSHIP_CACHE = "$Env:APPDATA\starship\"
}


Invoke-Starship -PathConfig "$Env:APPDATA\starship\starship.toml"
