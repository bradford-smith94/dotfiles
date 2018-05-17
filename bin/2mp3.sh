#!/bin/bash
# Bradford Smith
# ~/bin/2mp3.sh
# updated: 2018-05-13
# Use ffmpeg to convert all the files in a given directory to mp3

# takes in:
#   $1: file extension to find and convert
#   $2: directory in which to search for files [optional]

# sanitize PATH variable
PATH=$(command -p getconf PATH)

# need to at least take in the extension
if [ $# -lt 1 ]; then
    echo "usage: $0 <extension> [directory]"
    exit 1
fi

DEPS="ffmpeg mktemp grep"
for d in $DEPS; do
    if ! command -v "$d" >/dev/null 2>&1; then
        echo "$0: requires '$d'"
        exit 1
    fi
done

# taking in the directory is optional
if [ $# -eq 2 ]; then
    echo "entering: $2"
    cd "$2" || exit
fi

tmpfile=$(mktemp)

# find all matching files in the directory
find . -type f | grep ."$1"$ > "$tmpfile"

readarray -t files < "$tmpfile"

# for each matching file convert to mp3 and remove old file
for file in "${files[@]}"; do
    out=${file%.$1}.mp3
    ffmpeg -i "$file" -map_metadata 0:s:0 "$out"
    rm "$file"
done

# go back to where we were if we took in a directory
if [ $# -eq 2 ]; then
    echo "leaving: $2"
    cd - || exit
fi
