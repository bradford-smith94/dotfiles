#!/bin/sh
# Bradford Smith
# ~/bin/clip2qr.sh
# updated: 04/10/2018
# Generate and display a QR code from the contents of the system clipboard

DEPS="xclip qrencode"
for d in $DEPS; do
    if ! command -v "$d" >/dev/null 2>&1; then
        echo "$0: requires '$d'"
        exit 1
    fi
done

xclip -o | qrencode -t UTF8
