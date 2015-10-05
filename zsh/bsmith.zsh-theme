# Bradford Smith
# bsmith.zsh-theme
# updated: 10/04/2015
#####################

autoload -U colors && colors

setopt prompt_subst

# colors
local RESET="%{${reset_color}%}"
local WHITE="%{$fg[white]%}"
local BLACK="%{$fg[black]%}"
local GREEN="%{$fg[green]%}"
local RED="%{$fg[red]%}"
local BLUE="%{$fg[blue]%}"
local YELLOW="%{$fg[yellow]%}"
local CYAN="%{$fg[cyan]%}"
local MAGENTA="%{$fg[magenta]%}"

PROMPT_CHAR="%(!.${RED}#${RESET}.${GREEN}$ ${RESET})"

function user()
{
    if [[ $EUID -ne 0 ]]; then #not root -> green
        echo "${GREEN}%n${RESET}"
    else #root -> red
        echo "${RED}%n${RESET}"
    fi
}

function host()
{
    echo "%B${GREEN}@%M: ${RESET}%b"
}

function dir()
{
    echo "%B${BLUE}%~${RESET}%b"
}

# from github.com/SicK94/minimal/minimal.zsh-theme
function git_branch_name()
{
    local branch_name="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"
    [[ -n $branch_name ]] && echo "$branch_name"
}

# from github.com/SicK94/minimal/minimal.zsh-theme
function git_repo_status()
{
    local rs="$(git status --porcelain -b)"

    if $(echo "$rs" | grep -v '^##' &> /dev/null); then #dirty
        echo "${RED}"
    elif $(echo "$rs" | grep "^##.*diverged" &> /dev/null); then #diverged
        echo "${YELLOW}"
    elif $(echo "$rs" | grep "^##.*behind" &> /dev/null); then #behind
        echo "${RED}"
    elif $(echo "$rs" | grep "^##.*ahead" &> /dev/null); then #ahead
        echo "${GREEN}"
    else #clean
        echo "${RESET}"
    fi
}

# from github.com/SicK94/minimal/minimal.zsh-theme
function prompt_git()
{
    local branch=$(git_branch_name)
    if [[ -n $branch ]]; then
        local prompt="git:$(git_repo_status)%B$branch%b${RESET}"
        echo "$prompt"
    fi
}

function prompt_vimode()
{
    case $KEYMAP in
        main|viins)
            # echo "[%B${blue}INSERT%b${reset}]"
            ;;
        vicmd)
            echo "[%B${YELLOW}NORMAL%b${RESET}]"
            ;;
        viopp)
            echo "[%B${YELLOW}NORMAL%b${RESET}]"
            ;;
        visual)
            echo "[%B${RED}VISUAL%b${RESET}]"
            ;;
    esac
}

function zle-line-init zle-line-finish zle-keymap-select
{
    zle reset-prompt
    #zle -R
}

zle -N zle-line-init
zle -N zle-keymap-select
zle -N zle-line-finish


PROMPT="$(user)$(host)$(dir)$PROMPT_CHAR"
RPROMPT='$(prompt_vimode)$(prompt_git)'
