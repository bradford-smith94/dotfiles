#!/bin/sh
# Bradford Smith
# ~/bin/activeNetDev.sh
# updated: 04/10/2018
# Print the name of the active network device
# (that is, any that are a default route)

if command -v ip >/dev/null 2>&1; then
    ip route | sed -n 's/^default.*dev \(\S*\).*/\1/p'
elif command -v route >/dev/null 2>&1; then
    route | sed -n 's/^default.* \(\S*\)$/\1/p'
else
    echo "$0: requires one of: 'ip' or 'route'"
    exit 1
fi
