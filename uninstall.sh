#!/usr/bin/env bash
# Turn Off Screen - Linux Uninstaller
set -e

echo -e "\033[1;33m=== Uninstalling Turn Off Screen ===\033[0m"

rm -f "$HOME/.local/bin/turn-off-screen"
rm -f "$HOME/.local/share/applications/turn-off-screen.desktop"
rm -f "$HOME/Desktop/turn-off-screen.desktop" 2>/dev/null || true
rm -f "$HOME/.local/share/icons/hicolor/scalable/apps/turn-off-screen.svg"
rm -f "$HOME/.local/share/icons/hicolor/256x256/apps/turn-off-screen.png"

if command -v update-desktop-database >/dev/null 2>&1; then
    update-desktop-database "$HOME/.local/share/applications" >/dev/null 2>&1 || true
fi

if command -v kbuildsycoca6 >/dev/null 2>&1; then
    kbuildsycoca6 >/dev/null 2>&1 || true
fi

echo -e "\033[1;32m✓ Uninstallation complete.\033[0m"
