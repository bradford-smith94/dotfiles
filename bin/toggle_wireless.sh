#!/bin/sh
# Bradford Smith
# ~/bin/toggle_wireless.sh
# updated: 2018-05-13
# Toggle the state of the wireless adapters

# sanitize PATH variable
PATH=$(command -p getconf PATH)

DEPS="rfkill grep sudo"
for d in $DEPS; do
    if ! command -v "$d" >/dev/null 2>&1; then
        echo "$0: requires '$d'"
        exit 1
    fi
done

STATUS="Your wireless adapter has been"
ENABLED="$STATUS enabled."
DISABLED="$STATUS disabled."

if rfkill list wifi | grep "Soft blocked: yes" >/dev/null 2>&1; then
    sudo rfkill unblock wifi || exit 1
    notify-send -i network-wireless "Wireless Enabled" "$ENABLED" 2>/dev/null \
        || echo "$ENABLED"
else
    sudo rfkill block wifi || exit 1
    notify-send -i network-wireless "Wireless Disabled" "$DISABLED" 2>/dev/null \
        || echo "$DISABLED"
fi
