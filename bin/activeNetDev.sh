#!/bin/sh
# Bradford Smith
# ~/bin/activeNetDev.sh
# updated: 2018-05-16
# Print the name of the active network device
# (that is, any that are a default route)

# sanitize PATH variable
PATH=$(command -p getconf PATH)

if command -v ip >/dev/null 2>&1; then
    ip route | sed -n 's/^default.*dev \(\S*\).*/\1/p' | uniq
elif command -v route >/dev/null 2>&1; then
    route | sed -n 's/^default.* \(\S*\)$/\1/p' | uniq
else
    echo "$0: requires one of: 'ip' or 'route'"
    exit 1
fi
