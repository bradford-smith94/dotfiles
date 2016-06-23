#!/bin/bash
# Script for the pacman hook that updates the mirrorlist
# This file should be placed at `/etc/pacman.d/hooks/mirrorlist.sh`

# mirrorlist directory
dir=/etc/pacman.d

# remove mirrorlist.pacnew if it exists
if [ -f /etc/pacman.d/mirrorlist.pacnew ]; then
    rm /etc/pacman.d/mirrorlist.pacnew
fi

# backup old mirrorlist
mv $dir/mirrorlist $dir/mirrorlist.backup

# get new mirrorlist from archlinux.org
if wget -q -O $dir/mirrorlist https://www.archlinux.org/mirrorlist/all/ ; then

    # run reflector to sort mirrors by fastest 200 USA mirrors
    if reflector -c 'United States' -l 200 --sort rate --save $dir/mirrorlist ; then
        echo "Reflector updated mirrorlist successfully"
    else
        echo "Reflector failed, replacing old mirrorlist" 1>&2
        err=1
    fi
else
    echo "Wget failed, replacing old mirrorlist" 1>&2
    err=1
fi

# on error copy back the backed-up mirrorlist
if [[ $err -eq 1 ]]; then
    cp $dir/mirrorlist.backup $dir/mirrorlist
fi
