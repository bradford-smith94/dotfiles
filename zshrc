# Bradford Smith
# .zshrc
# updated: 11/10/2015
#####################

# theme it
source ~/.zsh/bsmith.zsh-theme

# unset history file
HISTFILE=

# use vim-like keybindings
bindkey -v
export KEYTIMEOUT=1

zmodload zsh/terminfo
# rebind backtab (shift-tab) to avoid switching to vicmd mode
bindkey -M viins "$terminfo[kcbt]" reverse-menu-complete

# use vim as the default editor and man pager
if [ -f /usr/bin/vim ]; then
    export EDITOR=/usr/bin/vim
    export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man' -\""
fi

# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle :compinstall filename '/home/bradford/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# https://unix.stackexchange.com/questions/52099/how-to-append-extend-zshell-completions
zstyle -s ':completion:*:hosts' hosts _ssh_config
[[ -r ~/.ssh/config ]] && _ssh_config+=($(cat ~/.ssh/config | sed -ne 's/Host[=\t ]//p'))
zstyle ':completion:*:hosts' hosts $_ssh_config


autoload -U zmv

# source aliases
if [ -f "$HOME/.shell_aliases" ]; then
    . ~/.shell_aliases
fi

# use dircolors to set $LC_COLORS
if [ -f /usr/bin/dircolors ]; then
    [ -e "$HOME/.dir_colors" ] && DIR_COLORS="$HOME/.dir_colors"
    [ -e "$DIR_COLORS" ] || DIR_COLORS=""
    eval "`dircolors -b $DIR_COLORS`"
fi

# if ~/bin exists add it to the beginning of the path
if [ -d ~/bin ]; then
    PATH=~/bin:$PATH
fi

# if ~/.scripts exists add it to the path
if [ -d ~/.scripts ]; then
    PATH=$PATH:~/.scripts
fi

PATH=$PATH:/opt/android-sdk/tools/
export PATH=$PATH

setopt autocd
setopt no_hup #prevent zsh from killing background processes

# if not in SSH
if [ "x${SSH_TTY}" = "x" ]; then
#   and screenfetch is installed
    if [ -f /usr/bin/screenfetch ]; then
        screenfetch
    fi
fi
