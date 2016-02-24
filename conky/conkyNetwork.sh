#!/bin/bash
# conkyNetwork.sh
# depends on bin/activeNetDev.sh

DEV=$(~/bin/activeNetDev.sh)
IP=$(ip addr show $DEV | grep "inet" | awk "{print \$2}")
CONNECTED=0
if [[ $DEV == "" ]]; then
    RESULT="Not Connected"
elif [[ $DEV == w* ]]; then #this is a wireless interface
    NETWORK=$(iwgetid -r $DEV)
    if [[ $NETWORK == "" ]]; then
        RESULT="$DEV: Not Connected"
    else
        RESULT="$DEV: $NETWORK"
        CONNECTED=1
    fi
else
    RESULT="$DEV: Connected"
    CONNECTED=1
fi

echo  "$RESULT"
if [[ $CONNECTED -eq 1 ]]; then
    echo "$IP"
fi
