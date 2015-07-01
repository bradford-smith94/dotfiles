#!/bin/bash
################################################################################
# Bradford Smith
# install.sh
# updated: 7/1/2015
#
# This script can be run to install my dotfiles.
#
# Inspired by: github.com/michaeljsmalley/dotfiles/makesymlinks.sh
#
################################################################################

########## Variables ###########################################################
usage="usage: \"$0 -[hir]\""

isRoot=0
interactive=0

# directories
dir=$HOME/.dotfiles
config=$HOME/.dotfiles/config

# backup directories
olddir=$HOME/.dotfiles_old
oldconfig=$HOME/.config_old

# list of files/folders to symlink in homedir
files="bashrc\
 bash_aliases\
 vimrc\
 vim\
 gitconfig\
 gitmessage\
 conkyrc\
 conky\
 tmux.conf\
 scripts"

# list of files/folders to symlink in homedir/.config
config_files="redshift.conf"
########## End Variables #######################################################

########## Functions ###########################################################
##### _help ####################################################################
function _help
{
    echo "$usage"
    echo "HELP Text"
}
##### End _help ################################################################

##### makeSymLinks #############################################################
# $1 destination, $2 source, $3 destination backup,
# $4 use dot (0|1), $5 files (can be a list)
function makeSymLinks
{
    dest=$1
    shift
    src=$1
    shift
    backup=$1
    shift
    useDot=$1
    shift
    files=$*

    echo "Moving any existing dotfiles from $dest to $backup"
    for file in $files; do
        if [ $useDot -eq 1 ]; then
            if [ "$(readlink $dest/.$file)" = $src/$file ]; then
                echo "$file is already linked here, skipping..."
            else
                mv $dest/.$file $backup/
                echo "Creating symlink to $file in $dest"
                ln -s $src/$file $dest/.$file
            fi
        else
            if [ "$(readlink $dest/$file)" = $src/$file ]; then
                echo "$file is already linked here, skipping..."
            else
                mv $dest/$file $backup/
                echo "Creating symlink to $file in $dest"
                ln -s $src/$file $dest/$file
            fi
        fi
    done
}
##### End makeSymLinks #########################################################
########## End Functions #######################################################

########## Code ################################################################
##### getopts ##################################################################
while getopts hir: FLAG; do
    case $FLAG in
        h) #help
            _help
            exit
            ;;
        i) #interactive
            interactive=1
            ;;
        r) #root
            if [[ $EUID -eq 0 ]]; then
                isRoot=1
            else
                echo "When running with \"-r\" you must use \"sudo\""
                exit
            fi
            ;;
        \?) #unrecognized flag
            echo "$usage"
            exit
            ;;
    esac
done

shift $((OPTIND-1)) #Moves getopts to the next argument
##### End getopts ##############################################################

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in $HOME"
mkdir -p $olddir

# create config_old in homedir
echo "Creating $oldconfig for backup of any existing files in $HOME/.config"
mkdir -p $oldconfig

# change to the dotfiles directory
echo ""
echo "#########################################"
echo "Changing to the $dir directory ..."
cd $dir

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the $HOME/dotfiles directory specified in $files
makeSymLinks $HOME $dir $olddir 1 $files

# change to config directory
echo ""
echo "#########################################"
echo "Changing to the $config directory ..."
cd $config

# move existing and make symlinks
makeSymLinks $HOME/.config $config $oldconfig 0 $config_files

echo ""
echo "#########################################"

# check if backup dirs are empty
if [ ! "$(ls -A $olddir)" ]; then
    echo "$olddir is empty, removing..."
    rmdir $olddir
fi

if [ ! "$(ls -A $oldconfig)" ]; then
    echo "$oldconfig is empty, removing..."
    rmdir $oldconfig
fi
########## End Code ############################################################
