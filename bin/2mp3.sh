#!/bin/bash
# 2mp3.sh
# Uses ffmpeg to convert all the files in a given directory to mp3
# takes in:
#   $1: file extension to find and convert
#   $2: directory in which to search for files [optional]

# need to at least take in the extension
[ $# -lt 1 ] && { echo "usage: 2mp3.sh <extension> [directory]"; exit 1; }

# don't do anything if we don't have ffmpeg
type ffmpeg >/dev/null 2>&1 || { echo >&2 "2mp3.sh requires ffmpeg"; exit -1; }

# taking in the directory is optional
[ $# -eq 2 ] && { echo "entering: $2"; cd "$2"; }

tmpfile=$(mktemp)

# find all matching files in the directory
find . -type f | grep .$1$ > $tmpfile

readarray -t files < $tmpfile

# for each matching file convert to mp3 and remove old file
for file in "${files[@]}"; do
    out=${file%.$1}.mp3
    ffmpeg -i "$file" -map_metadata 0:s:0 "$out"
    rm "$file"
done

# go back to where we were if we took in a directory
[ $# -eq 2] && { echo "leaving: $2"; cd -; }
