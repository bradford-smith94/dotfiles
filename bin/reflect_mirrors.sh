#!/bin/bash
##############
# Run reflector on /etc/pacman.d/mirrorlist to keep them up to date
# Bradford Smith
# updated: 09/14/2015
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

# get new mirrorlist from archlinux.org
wget -O $dir/mirrorlist.new https://www.archlinux.org/mirrorlist/all/

# backup old mirrorlist and replace with new one
cp $dir/mirrorlist $dir/mirrorlist.backup
mv $dir/mirrorlist.new $dir/mirrorlist

# run reflector to rank the mirrors
reflector --verbose -c 'United States' -l 200 --sort rate --save $dir/mirrorlist
