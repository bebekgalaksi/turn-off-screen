# Turn Off Screen - 1-Click Windows Installer
$ErrorActionPreference = "Stop"

$repo = "bebekgalaksi/turn-off-screen"
$rawUrl = "https://raw.githubusercontent.com/$repo/main"
$installDir = "$env:LOCALAPPDATA\TurnOffScreen"

Write-Host "=== Installing Turn Off Screen for Windows ===" -ForegroundColor Cyan

# Create destination directories
$binDir = Join-Path $installDir "bin"
$assetsDir = Join-Path $installDir "assets"
New-Item -ItemType Directory -Force -Path $binDir | Out-Null
New-Item -ItemType Directory -Force -Path $assetsDir | Out-Null

# Check if installing from local repo or remote download
$isLocal = $PSScriptRoot -and (Test-Path (Join-Path $PSScriptRoot "bin\turn-off-screen.vbs"))

if ($isLocal) {
    Write-Host "Installing from local files..." -ForegroundColor Gray
    Copy-Item -Path (Join-Path $PSScriptRoot "bin\*") -Destination $binDir -Recurse -Force
    Copy-Item -Path (Join-Path $PSScriptRoot "assets\*") -Destination $assetsDir -Recurse -Force
} else {
    Write-Host "Downloading latest version from GitHub..." -ForegroundColor Gray
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest -Uri "$rawUrl/bin/turn-off-screen.vbs" -OutFile (Join-Path $binDir "turn-off-screen.vbs")
    Invoke-WebRequest -Uri "$rawUrl/bin/turn-off-screen.cmd" -OutFile (Join-Path $binDir "turn-off-screen.cmd")
    Invoke-WebRequest -Uri "$rawUrl/bin/turn-off-screen.ps1" -OutFile (Join-Path $binDir "turn-off-screen.ps1")
    Invoke-WebRequest -Uri "$rawUrl/assets/icon.ico" -OutFile (Join-Path $assetsDir "icon.ico")
}

$vbsPath = Join-Path $binDir "turn-off-screen.vbs"
$icoPath = Join-Path $assetsDir "icon.ico"

# Create Desktop Shortcut
$desktop = [Environment]::GetFolderPath("Desktop")
$wscript = New-Object -ComObject WScript.Shell
$desktopShortcut = $wscript.CreateShortcut("$desktop\Turn off screen.lnk")
$desktopShortcut.TargetPath = "wscript.exe"
$desktopShortcut.Arguments = "`"$vbsPath`""
$desktopShortcut.WorkingDirectory = $binDir
$desktopShortcut.Description = "Turn off screen after 2 seconds"
if (Test-Path $icoPath) {
    $desktopShortcut.IconLocation = "$icoPath,0"
}
$desktopShortcut.Save()

# Create Start Menu Shortcut
$startMenu = [Environment]::GetFolderPath("Programs")
$startMenuShortcut = $wscript.CreateShortcut("$startMenu\Turn off screen.lnk")
$startMenuShortcut.TargetPath = "wscript.exe"
$startMenuShortcut.Arguments = "`"$vbsPath`""
$startMenuShortcut.WorkingDirectory = $binDir
$startMenuShortcut.Description = "Turn off screen after 2 seconds"
if (Test-Path $icoPath) {
    $startMenuShortcut.IconLocation = "$icoPath,0"
}
$startMenuShortcut.Save()

Write-Host ""
Write-Host "✓ Installation complete!" -ForegroundColor Green
Write-Host "  - Shortcut created on Desktop: 'Turn off screen'" -ForegroundColor White
Write-Host "  - Shortcut added to Start Menu: search 'Turn off screen' anytime" -ForegroundColor White
