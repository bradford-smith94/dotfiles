# Bradford Smith
# ~/.zshrc
# updated: 03/10/2018
#####################

# theme it
source "$HOME/.zsh/bsmith.zsh-theme"

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

# bind underscore to beginning-of-line in normal mode
bindkey -M vicmd "_" beginning-of-line

bindkey -M viins "" menu-complete
bindkey -M viins "" reverse-menu-complete

autoload -Uz compinit
compinit -d "$HOME/.zsh/.zcompdump"

zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'

# https://unix.stackexchange.com/questions/52099/how-to-append-extend-zshell-completions
zstyle -s ':completion:*:hosts' hosts _ssh_config
[[ -r ~/.ssh/config ]] && _ssh_config+=($(cat ~/.ssh/config | sed -ne 's/Host[=\t ]//p'))
zstyle ':completion:*:hosts' hosts $_ssh_config

# https://stackoverflow.com/a/38850556
zstyle ':completion:*:*:git:*' user-commands summary:'print a summary of author contributions'

# make ssh-ident use ssh completion
compdef ssh-ident=ssh

autoload -U zmv

setopt autocd
setopt globdots
setopt no_hup #prevent zsh from killing background processes

# source shared shell environment
if [ -f "$HOME/.shell_env" ]; then
    . $HOME/.shell_env
fi
