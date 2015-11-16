#!/bin/bash

if [ $(rfkill list bluetooth | grep "Soft blocked: yes" | wc -l) -ge 1 ]; then
    rfkill unblock bluetooth
    notify-send -i network-wireless-full "Bluetooth Enabled" "Your bluetooth adapter has been enabled."
else
    rfkill block bluetooth
    notify-send -i network-wireless-disconnected "Bluetooth Disabled" "Your bluetooth adapter has been disabled."
fi
