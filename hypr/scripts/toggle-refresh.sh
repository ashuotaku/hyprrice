#!/bin/sh

LOCK_FILE="/home/ashu/.local/state/display-refresh.lock"

if [ -f "$LOCK_FILE" ]; then
    # If locked, unlock it to enable the automatic switching
    rm -f "$LOCK_FILE"
    notify-send -a "System Power" -i "display" "Refresh Rate Auto-Switch" "STATUS: ENABLED\nDynamically adapting to charger states."
else
    # If unlocked, create the file to lock your current refresh rate
    touch "$LOCK_FILE"
    notify-send -a "System Power" -i "changes-prevent" "Refresh Rate Auto-Switch" "STATUS: LOCKED\nRefresh rate will remain frozen."
fi
