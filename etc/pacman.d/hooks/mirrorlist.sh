#!/bin/sh
# Script for the pacman hook that updates the mirrorlist
# This file should be placed at `/etc/pacman.d/hooks/mirrorlist.sh`

mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
reflector -c 'United States' -l 200 --sort rate --save /etc/pacman.d/mirrorlist

if [ -f /etc/pacman.d/mirrorlist.pacnew ]; then
    rm /etc/pacman.d/mirrorlist.pacnew
fi
