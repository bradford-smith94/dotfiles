#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
# Credit: github.com/michaeljsmalley/dotfiles/makesymlinks.sh
# Updated by: Bradford Smith
# Now also copies files to ~/.config/ and symlinks them here
############################

########## Variables
# dotfiles directory
dir=~/.dotfiles
config=~/.dotfiles/config

# old dotfiles backup directory
olddir=~/.dotfiles_old
oldconfig=~/.config_old

# list of files/folders to symlink in homedir
files="bashrc bash_aliases vimrc vim gitconfig gitmessage"
config_files="redshift.conf"

##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# create config_old in homedir
echo -n "Creating $oldconfig for backup of any existing files in ~/.config ..."
mkdir -p $oldconfig
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
	echo "Moving any existing dotfiles from ~ to $olddir"
	mv ~/.$file $olddir/
	echo "Creating symlink to $file in home directory."
	ln -s $dir/$file ~/.$file
done

# change to config directory
echo -n "Changing to the $config directory ..."
cd $config
echo "done"

# move existing and make symlinks
for file in $config_files; do
	echo "Moving any existing files from ~/.config to $oldconfig"
	mv ~/.config/$file $oldconfig/
	echo "Creating symlink to $file in ~/.config directory."
	ln -s $config/$file ~/.config/$file
done
