<#
.SYNOPSIS
    Turn Off Screen (PowerShell script)
.DESCRIPTION
    Waits 2 seconds and powers off the display using Win32 SendMessage API.
#>
Start-Sleep -Seconds 2
$signature = '[DllImport("user32.dll")] public static extern int SendMessage(int hWnd, int hMsg, int wParam, int lParam);'
$win32 = Add-Type -MemberDefinition $signature -Name "Win32SendMessage" -Namespace "Win32Functions" -PassThru
# HWND_BROADCAST = -1 (0xffff), WM_SYSCOMMAND = 0x0112, SC_MONITORPOWER = 0xF170, 2 = Power Off
[void]$win32::SendMessage(-1, 0x0112, 0xF170, 2)
