#!/bin/bash
#{{{############################################################################
# Bradford Smith
# install.sh
# updated: 02/17/2017
#
# This script can be run to install my dotfiles.
#
# Inspired by: github.com/michaeljsmalley/dotfiles/blob/master/makesymlinks.sh
#
#}}}############################################################################

#{{{ Variables #################################################################
usage="usage: \"$0 -[abfgh]\""

# install parameters
root=0
remove_broken_links=0
git_hooks=0
interactive=1
force=0

# colors
BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
L_GREY='\033[0;37m'
D_GREY='\033[1;30m'
L_RED='\033[1;31m'
L_GREEN='\033[1;32m'
L_YELLOW='\033[1;33m'
L_BLUE='\033[1;34m'
L_PURPLE='\033[1;35m'
L_CYAN='\033[1;36m'
WHITE='\033[1;37m'
NC='\033[0m'

# directories
dir=$(dirname $(readlink -f $0))
config=$dir/config
hooks_dir=$dir/.hooks
hooks_target=$dir/.git/hooks

# backup directories
olddir=$HOME/.dotfiles_old
oldconfig=$HOME/.config_old

installed_files=$(mktemp)

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
 shell_env\
 shell_aliases\
 dir_colors"

zsh_group="zshrc\
 zsh\
 shell_env\
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
# Show help text
function _help
{
    #use cat and a "here document" for printing the more verbose help
    cat <<EndHelpText
$usage
where:
    -a  (All) Skip the default interactive mode and link all files
    -b  (Broken links) Remove broken symlinks
    -f  (Force) Relink (unlink then link) any alreay linked files
    -g  (Git hooks) Install git hooks for this repository
    -h  (Help) Show this help text

Note: -b and -g are only necessary when not running interactively (-a)

EndHelpText
}
#}}} End _help #################################################################

#{{{ printSep ##################################################################
# Print a full terminal width separator line
# $1 (optional) character to draw the line with
function printSep
{
    if [ $# -gt 0 ]; then
        printf '\n%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' $1
    else
        printf '\n%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
    fi
}
#}}} End printSep ##############################################################

#{{{ promptYN ##################################################################
# Prompt the user with a yes or no question and get a true or false response
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
    response=$(echo $response | tr '[:upper:]' '[:lower:]')

    while [[ $response != "n" && \
        $response != "no" && \
        $response != "y" && \
        $response != "yes" ]]; do
        if [[ -z "$response" ]] && [[ -n "$default" ]]; then
            return $default
        fi
        echo -ne "${RED}Type 'y/yes' or 'n/no': ${NC}"
        read response
    done

    if [[ $response == "n" || \
        $reponse == "no" ]]; then
        return 1 #false
    elif [[ $response == "y" || \
        $reponse == "yes" ]]; then
        return 0 #true
    else # this shouldn't happen
        echo -e "${RED}Something went wrong${NC}"
        return 1 #false
    fi
}
#}}} End promptYN ##############################################################

#{{{ makeSymLinks ##############################################################
# Symlink a file
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
        if grep -q $file $installed_files ; then
            echo -e "${YELLOW}$file was already linked this session, skipping...${NC}"
            continue
        fi

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
                echo -e "${GREEN}Creating symlink to $file in $dest${NC}"
                unlink $target
                ln -s $src/$file $target
                echo $file >> $installed_files
            else
                echo -e "${CYAN}$file is already linked here, skipping...${NC}"
            fi
        else
            mv $target $backup/ 2> /dev/null
            echo -e "${GREEN}Creating symlink to $file in $dest${NC}"
            ln -s $src/$file $target
            echo $file >> $installed_files
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
        if grep -q $file $installed_files ; then
            echo -e "${YELLOW}$file was already linked this session, skipping...${NC}"
            continue
        fi

        target=$dest/$file
        if [ $useDot -eq 1 ]; then
            target=$dest/.$file
        fi # end if useDot
        if [ "$(readlink $target 2> /dev/null)" = $src/$file ]; then
            if [ $force -eq 1 ]; then
                echo -e "${GREEN}Creating symlink to $file in $dest${NC}"
                unlink $target
                ln -s $src/$file $target
                echo $file >> $installed_files
            else
                echo -e "${CYAN}$file is already linked here, skipping...${NC}"
            fi
        else
            mv $target $backup/ 2> /dev/null
            echo -e "${GREEN}Creating symlink to $file in $dest${NC}"
            ln -s $src/$file $target
            echo $file >> $installed_files
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
while getopts abfghr: FLAG; do
    case $FLAG in
        a) #all (skip interactive)
            interactive=0
            ;;
        b) #broken links
            remove_broken_links=1
            ;;
        f) #force
            force=1
            ;;
        g) #install git hooks
            git_hooks=1
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
printSep "="
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
printSep "="
echo "Changing to the $config directory ..."
cd $config

# move existing and make symlinks in $HOME/.config
makeSymLinks $HOME/.config $config $oldconfig 0 $config_files

# install git hooks
if [[ $interactive -eq 1 || $git_hooks -eq 1 ]]; then
    printSep "="
    echo "Install Git hooks for this repository"

    for hook in $hooks_dir/*; do
        if [ $interactive -eq 1 ]; then
            if ! promptYN "Copy $hook to $hooks_target" "y"; then
                continue
            fi
        fi
        echo -e "${GREEN}Copying $hook to $hooks_target${NC}"
        cp $hook $hooks_target
    done
fi

printSep "="

# check if backup dirs are empty and clean if they are
if [ ! "$(ls -A $olddir)" ]; then
    echo "$olddir is empty, removing..."
    rmdir $olddir
fi

if [ ! "$(ls -A $oldconfig)" ]; then
    echo "$oldconfig is empty, removing..."
    rmdir $oldconfig
fi

# check for broken symlinks

printSep "="

if [ $remove_broken_links -eq 1 ] || \
    [ $interactive -eq 1 ] && promptYN "Check for broken symlinks" ""; then

    broken=$(find $HOME -type l ! -exec test -e {} \; -print)

    if [ -n "$broken" ]; then
        echo -e "${RED}Detected broken symlinks${NC}"

        # prompt for deletion of broken links
        for link in $broken; do
            if promptYN "Remove broken link: $link" "y"; then
                rm $link
            fi
        done
    else
        echo -e "${GREEN}No broken symlinks detected${NC}"
    fi

    printSep "="
fi
#}}} End Code ##################################################################
