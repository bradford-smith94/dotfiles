# Bradford Smith
# .zshrc
# updated: 11/02/2016
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

# fix keys home
bindkey -M viins "[H" beginning-of-line
bindkey -M vicmd "[H" beginning-of-line

# fix keys end
bindkey -M viins "[F" end-of-line
bindkey -M vicmd "[F" end-of-line

# fix keys insert
bindkey -M viins "[2~" overwrite-mode
bindkey -M vicmd "[2~" overwrite-mode

# fix keys delete
bindkey -M viins "[3~" delete-char
bindkey -M vicmd "[3~" delete-char

# fix keys pgup
bindkey -M viins "[5~" up-history
bindkey -M vicmd "[5~" up-history

# fix keys pgdown
bindkey -M viins "[6~" down-history
bindkey -M vicmd "[6~" down-history

bindkey -M viins "" history-incremental-search-backward
bindkey -M vicmd "" history-incremental-search-backward

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
