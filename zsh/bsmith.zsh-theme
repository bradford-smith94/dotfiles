# Bradford Smith
# bsmith.zsh-theme
# updated: 10/04/2015
#####################

autoload -U colors && colors

setopt prompt_subst

# colors
local reset white black green red blue yellow cyan magenta
reset="%{${reset_color}%}"
white="%{$fg[white]%}"
black="%{$fg[black]%}"
green="%{$fg[green]%}"
red="%{$fg[red]%}"
blue="%{$fg[blue]%}"
yellow="%{$fg[yellow]%}"
cyan="%{$fg[cyan]%}"
magenta="%{$fg[magenta]%}"

PROMPT_CHAR="%(!.${red}#${reset}.${green}$ ${reset})"

function user()
{
    if [[ $EUID -ne 0 ]]; then #not root -> green
        echo "${green}%n${reset}"
    else #root -> red
        echo "${red}%n${reset}"
    fi
}

function host()
{
    echo "%B${green}@%M: ${reset}%b"
}

function dir()
{
    echo "%B${blue}%~${reset}%b"
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
        echo "${red}"
    elif $(echo "$rs" | grep "^##.*diverged" &> /dev/null); then #diverged
        echo "${yellow}"
    elif $(echo "$rs" | grep "^##.*behind" &> /dev/null); then #behind
        echo "${red}"
    elif $(echo "$rs" | grep "^##.*ahead" &> /dev/null); then #ahead
        echo "${green}"
    else #clean
        echo "${reset}"
    fi
}

# from github.com/SicK94/minimal/minimal.zsh-theme
function prompt_git()
{
    local branch=$(git_branch_name)
    if [[ -n $branch ]]; then
        local prompt="git:$(git_repo_status)%B$branch%b${reset}"
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
            echo "[%B${yellow}NORMAL%b${reset}]"
            ;;
        viopp)
            echo "[%B${yellow}NORMAL%b${reset}]"
            ;;
        visual)
            echo "[%B${red}VISUAL%b${reset}]"
            ;;
    esac
}

function zle-line-init zle-line-finish zle-keymap-select
{
    zle reset-prompt
    zle -R
}

zle -N zle-line-init
zle -N zle-keymap-select
zle -N zle-line-finish


PROMPT="$(user)$(host)$(dir)$PROMPT_CHAR"
RPROMPT='$(prompt_vimode)$(prompt_git)'
