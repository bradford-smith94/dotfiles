#!/bin/bash
##############
# Run reflector on /etc/pacman.d/mirrorlist to keep them up to date
# Bradford Smith
# updated: 06/23/2016
######################

# check to make sure we are running as root
if [[ $EUID -ne 0 ]]; then
    echo "Please run this script as root"
    exit 1
fi

# set mirrorlist dir
dir=/etc/pacman.d

# remove mirrorlist.pacnew if it exists
if [ -f $dir/mirrorlist.pacnew ]; then
    rm $dir/mirrorlist.pacnew
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
