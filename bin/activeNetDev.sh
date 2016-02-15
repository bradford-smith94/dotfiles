#!/bin/sh
# activeNetDev.sh
# Echos the name of the active network device

## nmcli way
# devices and statuses (using nmcli)
#DEVS=$(nmcli --terse --fields DEVICE,STATE dev status)

# echo the name of the connected network device
#echo "$DEVS" | grep "connected" | grep -v "disconnected" | sed 's/:.*//'

## ip way
# print ip routes
ROUTE=$(ip route)

# echo the name of the device that the default route uses
echo "$ROUTE" | sed -n 's/^default.*dev \(\S*\).*/\1/p'
