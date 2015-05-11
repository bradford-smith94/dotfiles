#!/bin/bash
##############
# Run reflector on ${dir}mirrorlist to keep them up to date
# Bradford Smith
# updated: 5/11/2015
####################

# check to make sure we are running as root
if [[ $EUID -ne 0 ]]; then
	echo "Please run this script as root"
	exit 1
fi

# set mirrorlist dir
dir=/etc/pacman.d

wget -O $dir/mirrorlist.new https://www.archlinux.org/mirrorlist/all/
cp $dir/mirrorlist $dir/mirrorlist.backup
mv $dir/mirrorlist.new $dir/mirrorlist
reflector --verbose -c 'United States' -l 200 --sort rate --save $dir/mirrorlist
