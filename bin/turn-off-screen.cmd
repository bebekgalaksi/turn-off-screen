@echo off
rem Turn Off Screen (Windows CMD runner)
rem Waits 2 seconds so mouse release or key release does not immediately wake the monitor.
powershell.exe -WindowStyle Hidden -Command "Start-Sleep -Seconds 2; (Add-Type '[DllImport(\"user32.dll\")]public static extern int SendMessage(int hWnd,int hMsg,int wParam,int lParam);' -Name a -Passthru)::SendMessage(-1,0x0112,0xF170,2)"
