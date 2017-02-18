#!/bin/sh
# Bradford Smith
# ~/bin/clip2qr.sh
# updated: 02/12/2017
# Simple script to generate a QR code from the contents of the clipboard

type xclip >/dev/null 2>&1 || { echo >&2 "Requires xclip"; exit 1; }
type qrencode >/dev/null 2>&1 || { echo >&2 "Requires qrencode"; exit 1; }

xclip -o | qrencode -t UTF8
