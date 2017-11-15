#!/bin/sh
# Bradford Smith
# ~/bin/toggle_wireless.sh
# Simple script to toggle the state of the wireless adapters

if rfkill list wifi | grep "Soft blocked: yes" >/dev/null 2>&1; then
    sudo rfkill unblock all
    notify-send -i network-wireless-full "Wireless Enabled" "Your wireless adapter has been enabled."
else
    sudo rfkill block all
    notify-send -i network-wireless-disconnected "Wireless Disabled" "Your wireless adapter has been disabled."
fi
