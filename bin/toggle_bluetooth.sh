#!/bin/sh
# Bradford Smith
# ~/bin/toggle_bluetooth.sh
# updated: 04/10/2018
# Toggle the state of the bluetooth adapter

DEPS="rfkill grep sudo"
for d in $DEPS; do
    if ! command -v "$d" >/dev/null 2>&1; then
        echo "$0: requires '$d'"
        exit 1
    fi
done

STATUS="Your bluetooth adapter has been"
ENABLED="$STATUS enabled."
DISABLED="$STATUS disabled."

if rfkill list bluetooth | grep "Soft blocked: yes" >/dev/null 2>&1; then
    sudo rfkill unblock bluetooth || exit 1
    notify-send -i network-wireless "Bluetooth Enabled" "$ENABLED" 2>/dev/null \
        || echo "$ENABLED"
else
    sudo rfkill block bluetooth || exit 1
    notify-send -i network-wireless "Bluetooth Disabled" "$DISABLED" 2>/dev/null \
        || echo "$DISABLED"
fi
