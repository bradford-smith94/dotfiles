# Bradford Smith
# ~/.zsh/bsmith.zsh-theme
# updated: 08/16/2016
#########################

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

local NEWLINE=$'\n'

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
    #if directory has at least 5 parts show the front 1 and last 2
    #else show the full cwd
    local dir="%(5C.%-1~/***/%2~.%~)"
    echo "%B${BLUE}$dir${RESET}%b"
}

#number of background jobs in cyan
function bgjobs()
{
    [[ $(jobs | wc -l) -gt 0 ]] && echo "jobs:${CYAN}%j${RESET}"
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
    local rs="$(git status --porcelain -b 2> /dev/null)"

    if $(echo "$rs" | grep -v '^##' &> /dev/null); then #dirty
        echo "${RED}"
    elif $(echo "$rs" | grep "^##.*diverged" &> /dev/null); then #diverged
        echo "${BLUE}"
    elif $(echo "$rs" | grep "^##.*ahead.*behind" &> /dev/null); then #diverged
        echo "${BLUE}"
    elif $(echo "$rs" | grep "^##.*behind" &> /dev/null); then #behind
        echo "${YELLOW}"
    elif $(echo "$rs" | grep "^##.*ahead" &> /dev/null); then #ahead
        echo "${GREEN}"
    else #clean
        echo "${RESET}"
    fi
}

function git_stash_count()
{
    local count="$(git stash list 2> /dev/null | wc -l)"

    [[ $count -gt 0 ]] && echo "${MAGENTA}{$count}${RESET}"
}

# from github.com/SicK94/minimal/minimal.zsh-theme
function prompt_git()
{
    local branch=$(git_branch_name)
    [[ -n $branch ]] && \
        echo "git:$(git_repo_status)%B$branch%b${RESET}$(git_stash_count)"
}

function prompt_vimode()
{
    case $KEYMAP in
        main|viins)
            # echo "[%B${BLUE}INSERT%b${RESET}]"
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

function prompt_topline()
{
    local vi_mode="$(prompt_vimode)"
    local bg_jobs="$(bgjobs)"
    local git_things="$(prompt_git)"
    local flag

    [[ -n $vi_mode ]] && echo -n $vi_mode" " && flag=true
    [[ -n $bg_jobs ]] && echo -n $bg_jobs" " && flag=true
    [[ -n $git_things ]] && echo -n $git_things" " && flag=true
    [[ $flag ]] && echo ${NEWLINE}"."
}

function zle-line-init zle-line-finish zle-keymap-select
{
    zle reset-prompt
    #zle -R
}

zle -N zle-line-init
zle -N zle-keymap-select
zle -N zle-line-finish

TL='${$(prompt_topline)%.}'
PROMPT="${TL}$(user)$(host)$(dir)$PROMPT_CHAR"
RPROMPT="${RED}%(?..%?)${RESET}"
