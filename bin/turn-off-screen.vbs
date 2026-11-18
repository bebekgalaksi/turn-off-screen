' Turn Off Screen (Windows VBScript silent runner)
' Waits 2 seconds so mouse release or key release does not immediately wake the monitor.
WScript.Sleep 2000

' Send SC_MONITORPOWER (0xF170) with 2 (power off) via WM_SYSCOMMAND (0x0112)
Dim objShell
Set objShell = CreateObject("WScript.Shell")
objShell.Run "powershell.exe -WindowStyle Hidden -Command ""(Add-Type '[DllImport(\""user32.dll\"")]public static extern int SendMessage(int hWnd,int hMsg,int wParam,int lParam);' -Name a -Passthru)::SendMessage(-1,0x0112,0xF170,2)""", 0, False
Set objShell = Nothing
