#!/bin/sh
# Bradford Smith
# ~/bin/toggle_touchpad.sh
# updated: 04/10/2018
# Toggle the state of the touchpad

# see also:
# https://wiki.archlinux.org/index.php/Touchpad_Synaptics#Software_toggle

DEPS="xinput grep awk"
for d in $DEPS; do
    if ! command -v "$d" >/dev/null 2>&1; then
        echo "$0: requires '$d'"
        exit 1
    fi
done

STATUS="Your touchpad has been"
ENABLED="$STATUS enabled."
DISABLED="$STATUS disabled."

ID=$(xinput list | grep -Eio 'touchpad\s*id\=[0-9]{1,2}' | grep -Eo '[0-9]{1,2}')
if [ -z "$ID" ]; then
    notify-send "No touchpad" "No touchpad detected." 2>/dev/null \
        || echo "No touchpad detected."
    exit 1
fi
STATE=$(xinput list-props "$ID" | grep 'Device Enabled' | awk '{print $4}')

if [ "$STATE" -eq 1 ]; then
    xinput disable "$ID" || exit 1
    notify-send -i input-mouse "Touchpad Disabled" "$DISABLED" 2>/dev/null \
        || echo "$DISABLED"
else
    xinput enable "$ID" || exit 1
    notify-send -i input-mouse "Touchpad Enabled" "$ENABLED" 2>/dev/null \
        || echo "$ENABLED"
fi
