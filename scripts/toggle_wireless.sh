#!/bin/bash

if [ $(rfkill list wifi | grep "Soft blocked: yes" | wc -l) -ge 1 ]; then
    rfkill unblock all
    notify-send -i network-wireless-full "Wireless Enabled" "Your wireless adapter has been enabled."
else
    rfkill block all
    notify-send -i network-wireless-disconnected "Wireless Disabled" "Your wireless adapter has been disabled."
fi
