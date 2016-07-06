# Bradford Smith
# .zshrc
# updated: 07/06/2016
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

# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

# https://unix.stackexchange.com/questions/52099/how-to-append-extend-zshell-completions
zstyle -s ':completion:*:hosts' hosts _ssh_config
[[ -r ~/.ssh/config ]] && _ssh_config+=($(cat ~/.ssh/config | sed -ne 's/Host[=\t ]//p'))
zstyle ':completion:*:hosts' hosts $_ssh_config


autoload -U zmv

setopt autocd
setopt no_hup #prevent zsh from killing background processes

# source shared shell environment
if [ -f "$HOME/.shell_env" ]; then
    . ~/.shell_env
fi
