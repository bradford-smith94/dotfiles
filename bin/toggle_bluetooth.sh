#!/bin/sh
# Bradford Smith
# ~/bin/toggle_bluetooth.sh
# Simple script to toggle the state of the bluetooth adapter

if rfkill list bluetooth | grep "Soft blocked: yes" >/dev/null 2>&1; then
    sudo rfkill unblock bluetooth
    notify-send -i network-wireless-full "Bluetooth Enabled" "Your bluetooth adapter has been enabled."
else
    sudo rfkill block bluetooth
    notify-send -i network-wireless-disconnected "Bluetooth Disabled" "Your bluetooth adapter has been disabled."
fi
