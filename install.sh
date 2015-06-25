#!/bin/bash
################################################################################
# This script can be run to install my dotfiles.
#
# Inspired by: github.com/michaeljsmalley/dotfiles/makesymlinks.sh
#
################################################################################

########## Functions ###########################################################

##### Basic ####################################################################
basic ()
{
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
    echo "#########################################"
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
}
##### End basic ################################################################

##### HELP #####################################################################
HELP ()
{
    echo "HELP"
}
##### End HELP #################################################################

########## End Functions #######################################################

########## Variables ###########################################################
# dotfiles directory
dir=$HOME/.dotfiles
config=$HOME/.dotfiles/config

# old dotfiles backup directory
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

########## getopts #############################################################
while getopts :a:h:i:r FLAG; do
    case $FLAG in
        a) #all
            basic
            ;;
        h) #help
            HELP
            exit
            ;;
        i) #interactive
            #stuff
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
            echo "Unrecognized option $OPTARG"
            HELP
            exit
            ;;
    esac
done

shift $((OPTIND-1)) #Moves getopts to the next argument
########## End getopts #########################################################

