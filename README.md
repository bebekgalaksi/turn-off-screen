# Turn Off Screen

A lightweight utility for Linux and Windows to turn off your display with a 2-second delay.

The 2-second pause gives you time to lift your hand from the mouse or keyboard so physical movement does not immediately wake the screen back up.

## Features

- **Cross-platform**: Native support for Linux (KDE Plasma, Wayland, X11) and Windows (PowerShell / Win32).
- **Silent execution**: No flashing terminal windows.
- **Full integration**: Automatically adds launcher entries to KDE Kickoff, GNOME application menus, and Windows Start Menu / Desktop.
- **Custom display icon**: Bundled modern screen sleep icon.

## Installation

### Linux
Run the installer directly:
```bash
bash install.sh
```
Or via curl:
```bash
curl -sSL https://raw.githubusercontent.com/bebekgalaksi/turn-off-screen/main/install.sh | bash
```

### Windows
Run in PowerShell:
```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1
```
Or via PowerShell one-liner:
```powershell
irm https://raw.githubusercontent.com/bebekgalaksi/turn-off-screen/main/install.ps1 | iex
```

## How It Works

- **Linux**: Triggers display DPMS power off via `kscreen-doctor --dpms off` on KDE Wayland (with fallbacks for Hyprland, Sway, and X11).
- **Windows**: Calls the Win32 `SendMessage` API (`WM_SYSCOMMAND`, `SC_MONITORPOWER`, `2`) silently via Windows Script Host and PowerShell.

## Uninstallation

- **Linux**: Run `bash uninstall.sh`
- **Windows**: Run `powershell -ExecutionPolicy Bypass -File .\uninstall.ps1`
