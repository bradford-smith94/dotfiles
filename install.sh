#!/bin/bash
#{{{############################################################################
# Bradford Smith
# install.sh
# updated: 05/31/2016
#
# This script can be run to install my dotfiles.
#
# Inspired by: github.com/michaeljsmalley/dotfiles/blob/master/makesymlinks.sh
#
#}}}############################################################################

#{{{ Variables #################################################################
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
files="tmux.conf\
 Xresources\
 xprofile"

# groups that have dependent files
vim_group="vimrc\
 vim"

git_group="gitconfig\
 gitignore\
 gitmessage"

bash_group="bashrc\
 shell_aliases\
 dir_colors"

zsh_group="zshrc\
 zsh\
 shell_aliases\
 dir_colors"

# list of files/folders to symlink in homedir without dot
no_dot_files="bin"

# list of files/folders to symlink in homedir/.config
config_files="redshift.conf\
 termite\
 conky\
 Xresources.d\
 cower"
#}}} End Variables #############################################################

#{{{ Functions #################################################################
#{{{ _help #####################################################################
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
#}}} End _help #################################################################

#{{{ promptYN ##################################################################
# $1 question, $2 default choice (y, n or "")
function promptYN
{
    question=$1
    shift
    choice=$1
    prompt=""
    default=""

    if [ "$choice" == "y" ]; then
        prompt="(Y/n)"
        default=0 #true
    elif [ "$choice" == "n" ]; then
        prompt="(y/N)"
        default=1 #false
    else
        prompt="(y/n)"
    fi

    echo -n "$question? $prompt "

    read response
    while [[ "$response" != "n" && \
        "$response" != "N" && \
        "$response" != "y" && \
        "$response" != "Y" ]]; do
        if [[ -z "$response" ]] && [[ -n "$default" ]]; then
            return $default
        fi
        echo -n "Type 'y' or 'n': "
        read response
    done

    if [[ "$response" == "n" || "$response" == "N" ]]; then
        return 1 #false
    elif [[ "$response" == "y" || "$response" == "Y" ]]; then
        return 0 #true
    else # this shouldn't happen
        echo "Something went wrong"
        return 1 #false
    fi
}
#}}} End promptYN ##############################################################

#{{{ makeSymLinks ##############################################################
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

    for file in $files; do
        if [ $interactive -eq 1 ]; then
            if ! promptYN "Link $file to $dest" "y"; then
                continue
            fi
        fi # end if interactive
        target=$dest/$file
        if [ $useDot -eq 1 ]; then
            target=$dest/.$file
        fi # end if useDot
        if [ "$(readlink $target 2> /dev/null)" = $src/$file ]; then
            if [ $force -eq 1 ]; then
                echo "Creating symlink to $file in $dest"
                unlink $target
                ln -s $src/$file $target
            else
                echo "$file is already linked here, skipping..."
            fi
        else
            mv $target $backup/ 2> /dev/null
            echo "Creating symlink to $file in $dest"
            ln -s $src/$file $target
        fi
    done
}
#}}} End makeSymLinks ##########################################################

#{{{ makeSymLinksGroup #########################################################
# Like makeSymLinks but for a group of dependent files (e.g. .vimrc and .vim/)
# $1 group, $2 hook function, $3 destination, $4 source,
# $5 destination backup, $6 use dot (0|1), $7 files (should be a list)
function makeSymLinksGroup
{
    group=$1
    shift
    hook=$1
    shift
    dest=$1
    shift
    src=$1
    shift
    backup=$1
    shift
    useDot=$1
    shift
    files=$*

    if [ $interactive -eq 1 ]; then
        if ! promptYN "Link $group to $dest" "y"; then
            return
        fi
    fi # end if interactive
    for file in $files; do
        target=$dest/$file
        if [ $useDot -eq 1 ]; then
            target=$dest/.$file
        fi # end if useDot
        if [ "$(readlink $target 2> /dev/null)" = $src/$file ]; then
            if [ $force -eq 1 ]; then
                echo "Creating symlink to $file in $dest"
                unlink $target
                ln -s $src/$file $target
            else
                echo "$file is already linked here, skipping..."
            fi
        else
            mv $target $backup/ 2> /dev/null
            echo "Creating symlink to $file in $dest"
            ln -s $src/$file $target
        fi
    done
    if [ "$hook" != "" ]; then
        $hook
    fi
}
#}}} End makeSymLinksGroup #####################################################
#}}} End Functions #############################################################

#{{{ Code ######################################################################
#{{{ getopts ###################################################################
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
#}}} End getopts ###############################################################

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
makeSymLinks $HOME $dir $olddir 0 $no_dot_files
makeSymLinksGroup "Vim Configuration" "vim +PluginInstall +qa" $HOME $dir $olddir 1 $vim_group
makeSymLinksGroup "Git Configuration" "source $dir/bin/hasGitPushSimple.sh" $HOME $dir $olddir 1 $git_group
makeSymLinksGroup "Bash Configuration" "" $HOME $dir $olddir 1 $bash_group
makeSymLinksGroup "Zsh Configuration" "" $HOME $dir $olddir 1 $zsh_group

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
#}}} End Code ##################################################################
