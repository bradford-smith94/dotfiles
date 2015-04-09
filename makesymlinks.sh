#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles
#   in ~/dotfiles
# Credit: github.com/michaeljsmalley/dotfiles/makesymlinks.sh
#
# Updated by: Bradford Smith
# Now also copies files to ~/.config/ and symlinks them here
#  and a few other improvements
############################

########## Variables
# dotfiles directory
dir=$HOME/.dotfiles
config=$HOME/.dotfiles/config

# old dotfiles backup directory
olddir=$HOME/.dotfiles_old
oldconfig=$HOME/.config_old

# list of files/folders to symlink in homedir
files="bashrc bash_aliases vimrc vim gitconfig gitmessage conkyrc"
config_files="redshift.conf"

##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in $HOME ..."
mkdir -p $olddir
echo "done"

# create config_old in homedir
echo -n "Creating $oldconfig for backup of any existing files in $HOME/.config ..."
mkdir -p $oldconfig
echo "done"

# change to the dotfiles directory
echo ""
echo "Changing to the $dir directory ..."
cd $dir

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the $HOME/dotfiles directory specified in $files
echo "Moving any existing dotfiles from $HOME to $olddir"
for file in $files; do
	if [ "$(readlink $HOME/.$file)" = $dir/$file ]
	then
		echo "$file is already linked here, skipping..."
	else
		mv $HOME/.$file $olddir/
		echo "Creating symlink to $file in home directory."
		ln -s $dir/$file $HOME/.$file
	fi
done

# change to config directory
echo ""
echo "Changing to the $config directory ..."
cd $config

# move existing and make symlinks
echo "Moving any existing files from $HOME/.config to $oldconfig"
for file in $config_files; do
	if [ "$(readlink $HOME/.config/$file)" = $config/$file ]
	then
		echo "$file is already linked here, skipping..."
	else
		mv $HOME/.config/$file $oldconfig/
		echo "Creating symlink to $file in $HOME/.config directory."
		ln -s $config/$file $HOME/.config/$file
	fi
done

echo ""

# check if backup dirs are empty
if [ ! "$(ls -A $olddir)" ]; then
	echo -n "$olddir is empty, removing..."
	rmdir $olddir
	echo "done"
fi

if [ ! "$(ls -A $oldconfig)" ]; then
	echo -n "$oldconfig is empty, removing..."
	rmdir $oldconfig
	echo "done"
fi
