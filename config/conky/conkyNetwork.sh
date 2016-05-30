#!/bin/bash
# conkyNetwork.sh
# depends on bin/activeNetDev.sh

DEV=$(~/bin/activeNetDev.sh)

echo "$DEV" | while read line; do

    IP=$(ip addr show $line | grep "inet" | awk "{print \$2}")
    CONNECTED=0
    if [[ $line == "" ]]; then
        RESULT="Not Connected"
    elif [[ $line == w* ]]; then #this is a wireless interface
        NETWORK=$(iwgetid -r $line)
        if [[ $NETWORK == "" ]]; then
            RESULT="\${color2}$line\${color}: Not Connected"
        else
            RESULT="\${color1}$line\${color}: $NETWORK"
            CONNECTED=1
        fi
    else
        RESULT="\${color1}$line\${color}: Connected"
        CONNECTED=1
    fi

    echo  "$RESULT"
    if [[ $CONNECTED -eq 1 ]]; then
        echo "$IP"
    fi

done
