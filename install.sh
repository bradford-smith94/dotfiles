#!/bin/bash
################################################################################
# Bradford Smith
# install.sh
# updated: 10/04/2015
#
# This script can be run to install my dotfiles.
#
# Inspired by: github.com/michaeljsmalley/dotfiles/makesymlinks.sh
#
################################################################################

########## Variables ###########################################################
usage="usage: \"$0 -[afhr]\""

root=0
interactive=1
force=0

# directories
dir=$HOME/.dotfiles
config=$HOME/.dotfiles/config

# backup directories
olddir=$HOME/.dotfiles_old
oldconfig=$HOME/.config_old

# list of files/folders to symlink in homedir
files="bashrc\
 shell_aliases\
 vimrc\
 vim\
 gitconfig\
 gitmessage\
 conkyrc\
 conky\
 tmux.conf\
 scripts\
 Xresources\
 dir_colors\
 zshrc\
 zsh\
 w3m"

# list of files/folders to symlink in homedir/.config
config_files="redshift.conf\
 Xresources.d\
 cower"
########## End Variables #######################################################

########## Functions ###########################################################
##### _help ####################################################################
function _help
{
    echo "$usage"
    printf "\nArguments:\n\
\t-a\tAll, skip the default interactive mode and link all files\n\
\t-f\tForce, relink (unlink then link) any alreay linked files\n\
\t-h\tShow this help text\n\
\t-r\tRoot, install these files for root also\n\
\nNote: the '-r' option does not currently do anything\n"
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
        if [ $interactive -eq 1 ]; then
            echo -n "Link $file to $dest?(y|n) "
            read -n 1 choice
            echo ""
            while [[ "$choice" != "n" && "$choice" != "y" ]]; do
                echo -n "Type 'y' or 'n': "
                read -n 1 choice
                echo ""
            done
            if [ $choice == "n" ]; then
                continue
            fi
        fi # end if interactive
        if [ $useDot -eq 1 ]; then
            if [ "$(readlink $dest/.$file)" = $src/$file ]; then
                if [ $force -eq 1 ]; then
                    echo "Creating symlink to $file in $dest"
                    ln -sf $src/$file $dest/.$file
                else
                    echo "$file is already linked here, skipping..."
                fi
            else
                mv $dest/.$file $backup/
                echo "Creating symlink to $file in $dest"
                ln -s $src/$file $dest/.$file
            fi
        else
            if [ "$(readlink $dest/$file)" = $src/$file ]; then
                if [ $force -eq 1 ]; then
                    echo "Creating symlink to $file in $dest"
                    ln -sf $src/$file $dest/$file
                else
                    echo "$file is already linked here, skipping..."
                fi
            else
                mv $dest/$file $backup/
                echo "Creating symlink to $file in $dest"
                ln -s $src/$file $dest/$file
            fi
        fi # end if useDot
    done
}
##### End makeSymLinks #########################################################
########## End Functions #######################################################

########## Code ################################################################
##### getopts ##################################################################
while getopts afhr: FLAG; do
    case $FLAG in
        a) #all (skip interactive)
            interactive=0
            ;;
        f) #force
            force=1
            ;;
        h) #help
            _help
            exit
            ;;
        r) #root
            root=1
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

# move any existing dotfiles in $HOME to $dotfiles_old directory, then create
# symlinks from the $HOME to any files in the $HOME/.dotfiles directory
# specified in $files
makeSymLinks $HOME $dir $olddir 1 $files

# change to config directory
echo ""
echo "#########################################"
echo "Changing to the $config directory ..."
cd $config

# move existing and make symlinks in $HOME/.config
makeSymLinks $HOME/.config $config $oldconfig 0 $config_files

echo ""
echo "#########################################"

# check if backup dirs are empty and clean if they are
if [ ! "$(ls -A $olddir)" ]; then
    echo "$olddir is empty, removing..."
    rmdir $olddir
fi

if [ ! "$(ls -A $oldconfig)" ]; then
    echo "$oldconfig is empty, removing..."
    rmdir $oldconfig
fi
########## End Code ############################################################
