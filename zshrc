# Bradford Smith
# .zshrc
# updated: 10/04/2015
#####################

# theme it
source ~/.zsh/bsmith.zsh-theme

# unset history file
HISTFILE=

# use vim-like keybindings
bindkey -v
export KEYTIMEOUT=1

# use vim as the default editor
if [ -f /usr/bin/vim ]; then
    export EDITOR=/usr/bin/vim
fi

# The following lines were added by compinstall
zstyle :compinstall filename '/home/bradford/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

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

setopt autocd

# if not in SSH
if [ "x${SSH_TTY}" = "x" ]; then
#   and screenfetch is installed
    if [ -f /usr/bin/screenfetch ]; then
        screenfetch
    fi
fi
