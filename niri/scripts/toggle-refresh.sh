#!/bin/sh

LOCK_FILE="$HOME/.local/state/display-refresh.lock"

if [ -f "$LOCK_FILE" ]; then
    # If locked, unlock it to enable the automatic switching
    rm -f "$LOCK_FILE"
    dms ipc call toast info "STATUS: ENABLED, Dynamically adapting to charger states."
else
    # If unlocked, create the file to lock your current refresh rate
    touch "$LOCK_FILE"
    dms ipc call toast info "STATUS: LOCKED, Refresh rate will remain frozen."
fi
