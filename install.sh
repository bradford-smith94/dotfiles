#!/bin/bash
#{{{############################################################################
# Bradford Smith
# install.sh
# updated: 02/24/2017
#
# This script can be run to install my dotfiles.
#
# Originally inspired by:
# https://github.com/michaeljsmalley/dotfiles/blob/master/makesymlinks.sh
#
#}}}############################################################################

#{{{ Variables #################################################################
usage="usage: \"$0 -[abfgh]\""

# booleans for ease of writing
# declared backwards from C standard so they can be used as return codes
TRUE=0
FALSE=1

# default install parameters
root=$FALSE
remove_broken_links=$FALSE
git_hooks=$FALSE
interactive=$TRUE
force=$FALSE

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

# project directories
dir=$(dirname $(readlink -f $0))
config=$dir/config
hooks_dir=$dir/.hooks

# target directories
# $HOME of course
config_target=$HOME/.config
hooks_target=$dir/.git/hooks

# backup directories
olddir=$HOME/.dotfiles_old
oldconfig=$HOME/.config_old

# keep a list of files installed (or attempted in the case it's already
# installed) this session
installed_files=$(mktemp)

# lists of files to install
# format: <file> <source dir> <target dir> <backup dir> <include a leading dot (true/false)>
files[0]="tmux.conf    $dir $HOME $olddir $TRUE"
files[1]="Xresources   $dir $HOME $olddir $TRUE"
files[2]="xprofile     $dir $HOME $olddir $TRUE"
files[3]="bin          $dir $HOME $olddir $FALSE"
files[4]="ctags        $dir $HOME $olddir $TRUE"
files[5]="redshift.conf     $config $config_target $oldconfig $FALSE"
files[6]="termite           $config $config_target $oldconfig $FALSE"
files[7]="conky             $config $config_target $oldconfig $FALSE"
files[8]="Xresources.d      $config $config_target $oldconfig $FALSE"
files[9]="cower             $config $config_target $oldconfig $FALSE"

# lists that represent a group of dependent files (that is the whole group
# should be installed in order for it to work properly)
vim[0]="vimrc  $dir $HOME $olddir $TRUE"
vim[1]="vim    $dir $HOME $olddir $TRUE"

git[0]="gitconfig  $dir $HOME $olddir $TRUE"
git[1]="gitignore  $dir $HOME $olddir $TRUE"
git[2]="gitmessage $dir $HOME $olddir $TRUE"

bash[0]="bashrc        $dir $HOME $olddir $TRUE"
bash[1]="shell_env     $dir $HOME $olddir $TRUE"
bash[2]="shell_aliases $dir $HOME $olddir $TRUE"
bash[3]="dir_colors    $dir $HOME $olddir $TRUE"

zsh[0]="zshrc          $dir $HOME $olddir $TRUE"
zsh[1]="zsh            $dir $HOME $olddir $TRUE"
zsh[2]="shell_env      $dir $HOME $olddir $TRUE"
zsh[3]="shell_aliases  $dir $HOME $olddir $TRUE"
zsh[4]="dir_colors     $dir $HOME $olddir $TRUE"

bspwm[0]="bspwm         $config $config_target $oldconfig $FALSE"
bspwm[1]="sxhkd         $config $config_target $oldconfig $FALSE"
bspwm[2]="polybar       $config $config_target $oldconfig $FALSE"
bspwm[3]="rofi          $config $config_target $oldconfig $FALSE"
bspwm[4]="redshift.conf $config $config_target $oldconfig $FALSE"
bspwm[5]="xinitrc       $dir    $HOME          $olddir    $TRUE"
bspwm[6]="xprofile      $dir    $HOME          $olddir    $TRUE"

#}}} End Variables #############################################################

#{{{ Functions #################################################################
#{{{ _help ---------------------------------------------------------------------
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
#}}} End _help -----------------------------------------------------------------

#{{{ printSep ------------------------------------------------------------------
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
#}}} End printSep --------------------------------------------------------------

#{{{ promptYN ------------------------------------------------------------------
# Prompt the user with a yes or no question and get a true or false response
# $1 question, $2 default choice (y, n or "")
function promptYN
{
    question=$1
    choice=$2
    prompt=""
    default=""

    if [ "$choice" == "y" ]; then
        prompt="(Y/n)"
        default=$TRUE
    elif [ "$choice" == "n" ]; then
        prompt="(y/N)"
        default=$FALSE
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
        return $FALSE
    elif [[ $response == "y" || \
        $reponse == "yes" ]]; then
        return $TRUE
    else # this shouldn't happen
        echo -e "${RED}Something went wrong${NC}"
        return $FALSE
    fi
}
#}}} End promptYN --------------------------------------------------------------

#{{{ makeSymLink ---------------------------------------------------------------
# Symlink a file
# $1 file, $2 source, $3 destination, $4 backup directory, $5 use a dot
function makeSymLink
{
    file=$1
    src=$2
    dest=$3
    backup=$4
    useDot=$5

    if grep -wq $file $installed_files ; then
        echo -e "${YELLOW}$file was already done this session, skipping...${NC}"
        return
    fi

    if [ $interactive -eq $TRUE ]; then
        if ! promptYN "Link $file to $dest" "y"; then
            return
        fi
    fi # end if interactive

    target=$dest/$file
    if [ $useDot -eq $TRUE ]; then
        target=$dest/.$file
    fi # end if useDot

    echo $file >> $installed_files
    if [ "$(readlink $target 2> /dev/null)" = $src/$file ]; then
        if [ $force -eq $TRUE ]; then
            echo -e "${GREEN}Creating symlink to $file in $dest${NC}"
            unlink $target
            ln -s $src/$file $target
        else
            echo -e "${CYAN}$file is already linked here, skipping...${NC}"
        fi
    else
        mv $target $backup/ 2> /dev/null
        echo -e "${GREEN}Creating symlink to $file in $dest${NC}"
        ln -s $src/$file $target
    fi
}
#}}} End makeSymLinks ----------------------------------------------------------
#}}} End Functions #############################################################

#{{{ Code ######################################################################
#{{{ getopts -------------------------------------------------------------------
while getopts abfghr: FLAG; do
    case $FLAG in
        a) #all (skip interactive)
            interactive=$FALSE
            ;;
        b) #broken links
            remove_broken_links=$TRUE
            ;;
        f) #force
            force=$TRUE
            ;;
        g) #install git hooks
            git_hooks=$TRUE
            ;;
        h) #help
            _help
            exit
            ;;
        r) #root
            root=$TRUE
            ;;
        \?) #unrecognized flag
            echo "$usage"
            exit
            ;;
    esac
done

shift $((OPTIND-1)) #Moves getopts to the next argument
#}}} End getopts ---------------------------------------------------------------

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in $HOME"
mkdir -p $olddir

# create config_old in homedir
echo "Creating $oldconfig for backup of any existing files in $HOME/.config"
mkdir -p $oldconfig

# create config_target
echo "Creating $config_target in case it doesn't exist yet"
mkdir -p $config_target

#{{{ install dotfiles ----------------------------------------------------------
printSep "="

# install non-dependent files from the 'files' list
for ((i = 0; i < ${#files[@]}; i++)); do
    arr=(${files[$i]})
    makeSymLink ${arr[0]} ${arr[1]} ${arr[2]} ${arr[3]} ${arr[4]}
done

# install Vim group
if [ $interactive -eq $FALSE ] || promptYN "Link Vim Configuration group" "y"; then
    saved_interactive=$interactive
    interactive=$FALSE #don't prompt for dependent files

    for ((i = 0; i < ${#vim[@]}; i++)); do
        arr=(${vim[$i]})
        makeSymLink ${arr[0]} ${arr[1]} ${arr[2]} ${arr[3]} ${arr[4]}
    done

    interactive=$saved_interactive
fi

# install Git group
if [ $interactive -eq $FALSE ] || promptYN "Link Git Configuration group" "y"; then
    saved_interactive=$interactive
    interactive=$FALSE #don't prompt for dependent files

    for ((i = 0; i < ${#git[@]}; i++)); do
        arr=(${git[$i]})
        makeSymLink ${arr[0]} ${arr[1]} ${arr[2]} ${arr[3]} ${arr[4]}
    done

    interactive=$saved_interactive
    $dir/bin/hasGitPushSimple.sh
fi

# install Bash group
if [ $interactive -eq $FALSE ] || promptYN "Link Bash Configuration group" "y"; then
    saved_interactive=$interactive
    interactive=$FALSE #don't prompt for dependent files

    for ((i = 0; i < ${#bash[@]}; i++)); do
        arr=(${bash[$i]})
        makeSymLink ${arr[0]} ${arr[1]} ${arr[2]} ${arr[3]} ${arr[4]}
    done

    interactive=$saved_interactive
fi

# install Zsh group
if [ $interactive -eq $FALSE ] || promptYN "Link Zsh Configuration group" "y"; then
    saved_interactive=$interactive
    interactive=$FALSE #don't prompt for dependent files

    for ((i = 0; i < ${#zsh[@]}; i++)); do
        arr=(${zsh[$i]})
        makeSymLink ${arr[0]} ${arr[1]} ${arr[2]} ${arr[3]} ${arr[4]}
    done

    interactive=$saved_interactive
fi

# install Bspwm group
if [ $interactive -eq $FALSE ] || promptYN "Link Bspwm Configuration group" "y"; then
    saved_interactive=$interactive
    interactive=$FALSE #don't prompt for dependent files

    for ((i = 0; i < ${#bspwm[@]}; i++)); do
        arr=(${bspwm[$i]})
        makeSymLink ${arr[0]} ${arr[1]} ${arr[2]} ${arr[3]} ${arr[4]}
    done

    interactive=$saved_interactive
fi
#}}} end install dotfiles ------------------------------------------------------

# install git hooks
if [[ $interactive -eq $TRUE || $git_hooks -eq $TRUE ]]; then
    printSep "="
    echo "Install Git hooks for this repository"

    for hook in $hooks_dir/*; do
        if [ $interactive -eq $TRUE ]; then
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

if [ ! "$(ls -A $config_target)" ]; then
    echo "$config_target is empty, we must have created it, removing..."
    rmdir $config_target
fi

# check for broken symlinks

printSep "="

if [ $remove_broken_links -eq $TRUE ] || \
    [ $interactive -eq $TRUE ] && promptYN "Check for broken symlinks" ""; then

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
