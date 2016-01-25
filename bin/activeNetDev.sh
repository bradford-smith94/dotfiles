#!/bin/bash
# activeNetDev.sh
# Echos the name of the active network device

#devices and statuses
DEVS=$(nmcli --terse --fields DEVICE,STATE dev status)

#echo the name of the connected network device
echo "$DEVS" | grep "connected" | grep -v "disconnected" | sed 's/:.*//'
