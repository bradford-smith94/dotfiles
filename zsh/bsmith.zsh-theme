# Bradford Smith
# bsmith.zsh-theme
# updated: 10/13/2015
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

#red # if root, else green $
PROMPT_CHAR="%(!.${RED}#${RESET}.${GREEN}$ ${RESET})"

function user()
{
    #echo name in red if root, else name in green
    echo "%(!.${RED}%n${RESET}.${GREEN}%n${RESET})"
}

function host()
{
    echo "%B${GREEN}@%M: ${RESET}%b"
}

function dir()
{
    #if directory has at least 5 parts show the front 2 and last 1
    #else show the full cwd
    local dir="%(5C.%-2~/***/%1~.%~)"
    echo "%B${BLUE}$dir${RESET}%b"
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
        echo "${BLUE}"
    elif $(echo "$rs" | grep "^##.*behind" &> /dev/null); then #behind
        echo "${YELLOW}"
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
