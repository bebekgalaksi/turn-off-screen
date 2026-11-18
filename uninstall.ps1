# Turn Off Screen - Windows Uninstaller
$ErrorActionPreference = "SilentlyContinue"

Write-Host "=== Uninstalling Turn Off Screen ===" -ForegroundColor Yellow

$desktop = [Environment]::GetFolderPath("Desktop")
$startMenu = [Environment]::GetFolderPath("Programs")
$installDir = "$env:LOCALAPPDATA\TurnOffScreen"

Remove-Item -Force "$desktop\Turn off screen.lnk"
Remove-Item -Force "$startMenu\Turn off screen.lnk"

if (Test-Path $installDir) {
    Remove-Item -Recurse -Force $installDir
}

Write-Host "✓ Turn Off Screen removed successfully." -ForegroundColor Green
