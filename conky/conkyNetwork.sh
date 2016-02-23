#!/bin/bash
# conkyNetwork.sh
# depends on bin/activeNetDev.sh

DEV=$(~/bin/activeNetDev.sh)
if [[ $DEV == "" ]]; then
    RESULT="Not Connected"
elif [[ $DEV == w* ]]; then #this is a wireless interface
    NETWORK=$(iwgetid -r $DEV)
    if [[ $NETWORK == "" ]]; then
        RESULT="$DEV: Not Connected"
    else
        RESULT="$DEV: $NETWORK"
    fi
else
    RESULT="$DEV: Connected"
fi

echo  "$RESULT"
