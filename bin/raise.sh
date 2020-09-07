#!/bin/bash
# Bradford Smith
# ~/bin/raise.sh
# updated: 2020-08-22
# Use wmctrl to raise a window if it exists or launch the command

# sanitize PATH variable
PATH=$(command -p getconf PATH)

USAGE="$(basename "$0") <program name>"

DEPS="wmctrl"
for d in $DEPS; do
    if ! command -v "$d" >/dev/null 2>&1; then
        echo "$0: requires '$d'"
        exit 1
    fi
done

if [ $# -ne 1 ]; then
    echo "$USAGE"
    exit 2
fi
PRG=$1

WMNAME=$(wmctrl -xl | grep -i "$PRG" | cut -d' ' -f 4)
if [ -n "$WMNAME" ]; then
    #echo "$WMNAME"
    wmctrl -xa "$WMNAME"
else
    $PRG 2>/dev/null
fi
