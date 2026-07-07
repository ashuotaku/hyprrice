#!/bin/sh

# Exit early if a temporary lock file exists in user local share folder
if [ -f "/home/ashu/.local/share/hyprland-refresh.lock" ]; then
    exit 0
fi

# Target your local user account
HYPR_USER="ashu"
HYPR_UID=$(id -u $HYPR_USER)

# Find the active Hyprland socket signature
HYPR_SIGNATURE=$(ls /run/user/$HYPR_UID/hypr/ 2>/dev/null | grep -v "xdg" | head -n1)

# Fallback path if empty
if [ -z "$HYPR_SIGNATURE" ]; then
    HYPR_SIGNATURE=$(ls /tmp/hypr/ 2>/dev/null | head -n1)
fi

# Run the dynamic Lua code wrapped inside your user profile environment
case "$1" in
    bat)
        # Unplugged: Lower to 60Hz using native Lua helper API
        su - $HYPR_USER -c "export HYPRLAND_INSTANCE_SIGNATURE=$HYPR_SIGNATURE; export XDG_RUNTIME_DIR=/run/user/$HYPR_UID; hyprctl eval 'hl.monitor({ output = \"eDP-1\", mode = \"1920x1080@60\", position = \"0x0\", scale = 1.25 })'"
        ;;
    ac)
        # Plugged in: Crank back to 144Hz using native Lua helper API
        su - $HYPR_USER -c "export HYPRLAND_INSTANCE_SIGNATURE=$HYPR_SIGNATURE; export XDG_RUNTIME_DIR=/run/user/$HYPR_UID; hyprctl eval 'hl.monitor({ output = \"eDP-1\", mode = \"1920x1080@144\", position = \"0x0\", scale = 1.25 })'"
        ;;
esac

exit 0
