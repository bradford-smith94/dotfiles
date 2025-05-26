#!/bin/bash

if [ $# -eq 1 ]
then
    dir=$1
elif [ $# -le 1 ]
then
    dir="."
else
    echo "usage: $0 <directory>"
    exit 1
fi

find "$dir" -type d -exec chmod 755 {} +
find "$dir" -type f -exec chmod 644 {} +
