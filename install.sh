#!/usr/bin/env bash
# Turn Off Screen - Linux 1-Click Installer
set -e

REPO="bebekgalaksi/turn-off-screen"
RAW_URL="https://raw.githubusercontent.com/$REPO/main"

BIN_DIR="$HOME/.local/bin"
DESKTOP_DIR="$HOME/.local/share/applications"
ICON_SVG_DIR="$HOME/.local/share/icons/hicolor/scalable/apps"
ICON_PNG_DIR="$HOME/.local/share/icons/hicolor/256x256/apps"

echo -e "\033[1;36m=== Installing Turn Off Screen ===\033[0m"

# Ensure directories exist
mkdir -p "$BIN_DIR"
mkdir -p "$DESKTOP_DIR"
mkdir -p "$ICON_SVG_DIR"
mkdir -p "$ICON_PNG_DIR"

# Determine script source: local directory or remote download
SCRIPT_DIR=""
if [ -n "${BASH_SOURCE[0]}" ] && [ -f "${BASH_SOURCE[0]}" ]; then
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi

if [ -n "$SCRIPT_DIR" ] && [ -f "$SCRIPT_DIR/bin/turn-off-screen.sh" ]; then
    echo "Installing from local repository..."
    cp "$SCRIPT_DIR/bin/turn-off-screen.sh" "$BIN_DIR/turn-off-screen"
    cp "$SCRIPT_DIR/assets/icon.svg" "$ICON_SVG_DIR/turn-off-screen.svg"
    cp "$SCRIPT_DIR/assets/icon.png" "$ICON_PNG_DIR/turn-off-screen.png"
    cp "$SCRIPT_DIR/turn-off-screen.desktop" "$DESKTOP_DIR/turn-off-screen.desktop"
else
    echo "Downloading latest version from GitHub..."
    curl -sSL "$RAW_URL/bin/turn-off-screen.sh" -o "$BIN_DIR/turn-off-screen"
    curl -sSL "$RAW_URL/assets/icon.svg" -o "$ICON_SVG_DIR/turn-off-screen.svg"
    curl -sSL "$RAW_URL/assets/icon.png" -o "$ICON_PNG_DIR/turn-off-screen.png"
    curl -sSL "$RAW_URL/turn-off-screen.desktop" -o "$DESKTOP_DIR/turn-off-screen.desktop"
fi

# Make binary and desktop file executable
chmod +x "$BIN_DIR/turn-off-screen"
chmod +x "$DESKTOP_DIR/turn-off-screen.desktop"

# Refresh desktop and icon caches
if command -v update-desktop-database >/dev/null 2>&1; then
    update-desktop-database "$DESKTOP_DIR" >/dev/null 2>&1 || true
fi

if command -v gtk-update-icon-cache >/dev/null 2>&1; then
    gtk-update-icon-cache -q "$HOME/.local/share/icons/hicolor" >/dev/null 2>&1 || true
fi

if command -v kbuildsycoca6 >/dev/null 2>&1; then
    kbuildsycoca6 >/dev/null 2>&1 || true
elif command -v kbuildsycoca5 >/dev/null 2>&1; then
    kbuildsycoca5 >/dev/null 2>&1 || true
fi

echo ""
echo -e "\033[1;32m✓ Installed successfully!\033[0m"
echo -e "  - Binary:  $BIN_DIR/turn-off-screen"
echo -e "  - Desktop: $DESKTOP_DIR/turn-off-screen.desktop"
echo -e "  - Icon:    $ICON_SVG_DIR/turn-off-screen.svg"
echo ""
echo "You can now find 'Turn off screen' in your Application Menu (KDE Kickoff, GNOME, etc.)!"
