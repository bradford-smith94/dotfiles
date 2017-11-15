#!/bin/sh
# Bradford Smith
# ~/bin/toggle_webcam.sh
# Simple script to toggle the loaded state of the webcam kernel module

MOD=uvcvideo

if lsmod | grep $MOD >/dev/null 2>&1; then
    sudo rmmod $MOD
    notify-send "Webcam Disabled" "Your $MOD kernel module has been unloaded."
else
    sudo modprobe $MOD
    notify-send "Webcam Enabled" "Your $MOD kernel module has been loaded."
fi
