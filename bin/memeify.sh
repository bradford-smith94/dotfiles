#!/bin/sh
# Bradford Smith
# ~/bin/memeify.sh
# Use imagemagick to create a meme from a given image and some text

usage="$0 [input file] <top text> <bottom text> <output filename>"

if ! command -v identify >/dev/null 2>&1; then
    echo "The 'identify' command from imagemagick is required"
    exit 1
fi

if ! command -v convert >/dev/null 2>&1; then
    echo "The 'convert' command from imagemagick is required"
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "$usage"
    exit 2
fi

if [ -z "$4" ]; then
    outfile="meme.png"
else
    outfile="$4"
fi

width=$(identify -format %w "$1")
height=$(identify -format %h "$1")
height=$((height / 6))

convert "$1" -background none -stroke black -strokewidth 4 -fill white \
    -gravity center -size "${width}"x"${height}" -font Impact caption:"$2" \
    -gravity north -composite -background none -stroke black -strokewidth 4 \
    -fill white -gravity center -size "${width}"x"${height}" -font Impact \
    caption:"$3" -gravity south -composite "$outfile"

echo "Meme written to $outfile"
