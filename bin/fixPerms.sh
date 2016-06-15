#!/bin/bash
# fixPerms.sh
# Recursively chmods directories to 755 and their files to 644
# takes in:
#   $1: directory to work in [optional]

# if given an argument assume it's a directory
[ $# -eq 1 ] && { echo "entering: $1"; cd "$1"; }

# set all directories to 755 and all files to 644
find . -type d -exec chmod 755 {} \;
find . -type f -exec chmod 644 {} \;

# if we were given a directory go back to where we were before
[ $# -eq 1 ] && { echo "leaving: $1"; cd -; }
