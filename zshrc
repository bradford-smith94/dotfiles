# Bradford Smith
# .zshrc
# updated: 10/05/2015
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

# use vim as the default editor
if [ -f /usr/bin/vim ]; then
    export EDITOR=/usr/bin/vim
fi

# The following lines were added by compinstall
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

setopt autocd

# if not in SSH
if [ "x${SSH_TTY}" = "x" ]; then
#   and screenfetch is installed
    if [ -f /usr/bin/screenfetch ]; then
        screenfetch
    fi
fi
