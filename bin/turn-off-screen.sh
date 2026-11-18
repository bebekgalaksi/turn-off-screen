#!/usr/bin/env bash
# Turn Off Screen (Linux)
# Waits 2 seconds so mouse release or key release does not immediately wake the monitor.
sleep 2

# 1. KDE Plasma (Wayland) via kscreen-doctor
if command -v kscreen-doctor >/dev/null 2>&1; then
    kscreen-doctor --dpms off
    exit 0
fi

# 2. Hyprland
if command -v hyprctl >/dev/null 2>&1; then
    hyprctl dispatch dpms off
    exit 0
fi

# 3. Sway
if command -v swaymsg >/dev/null 2>&1; then
    swaymsg "output * dpms off"
    exit 0
fi

# 4. wlroots (generic Wayland via wlopm)
if command -v wlopm >/dev/null 2>&1; then
    wlopm --off \*
    exit 0
fi

# 5. GNOME / D-Bus screen saver blanking
if command -v gdbus >/dev/null 2>&1; then
    gdbus call --session --dest org.gnome.ScreenSaver --object-path /org/gnome/ScreenSaver --method org.gnome.ScreenSaver.SetActive true >/dev/null 2>&1 && exit 0
fi

# 6. X11 via xset
if [ -n "$DISPLAY" ] && command -v xset >/dev/null 2>&1; then
    xset dpms force off
    exit 0
fi

echo "Error: No supported display manager or DPMS utility found." >&2
exit 1
