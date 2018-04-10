#!/bin/sh
# Bradford Smith
# ~/bin/toggle_webcam.sh
# updated: 04/10/2018
# Toggle the loaded state of the webcam kernel module

DEPS="lsmod rmmod modprobe grep sudo"
for d in $DEPS; do
    if ! command -v "$d" >/dev/null 2>&1; then
        echo "$0: requires '$d'"
        exit 1
    fi
done

MOD=uvcvideo
STATUS="Your $MOD kernel module has been"
ENABLED="$STATUS loaded."
DISABLED="$STATUS unloaded."

if lsmod | grep $MOD >/dev/null 2>&1; then
    sudo rmmod $MOD || exit 1
    notify-send -i camera-web "Webcam Disabled" "$DISABLED" 2>/dev/null \
        || echo "$DISABLED"
else
    sudo modprobe $MOD || exit 1
    notify-send -i camera-web "Webcam Enabled" "$ENABLED" 2>/dev/null \
        || echo "$ENABLED"
fi
