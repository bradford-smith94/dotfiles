# Bradford Smith
# ~/.bashrc
# updated: 2024-01-22
#####################

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source global definitions
if [ -f /etc/bash.bashrc ]; then
    . /etc/bash.bashrc
fi

# bash history file
if [ ! -d "$HOME/.bash" ]; then
    mkdir "$HOME/.bash/"
fi
HISTFILE="$HOME/.bash/history"
HISTSIZE=100000
SAVEHIST=100000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# use vi input mode
set -o vi

# check if we're connected via SSH
if [ "x$SSH_TTY" != "x" ]; then
    SSH="\[\e[0;31m\](ssh) \[\e[m\]"
else
    SSH=""
fi

# check for network namespace
nns=$(ip netns identify)
if [ -n "$nns" ]; then
    NNS="(nns: $nns) "
else
    NNS=""
fi

# Prompt
if [[ $EUID -ne 0 ]]; then
    # | user - green
    PROMPT_USER="\[\e[0;32m\]\u\[\e[m\]"
    # | @host - bright green
    PROMPT_HOST="\[\e[1;32m\]@\h:\[\e[m\]"
    # | $ - green
    PROMPT_CHAR="\[\e[0;32m\]\$\[\e[m\]"
else
    # | user - red
    PROMPT_USER="\[\e[0;31m\]\u\[\e[m\]"
    # | @host - bright red
    PROMPT_HOST="\[\e[1;31m\]@\h:\[\e[m\]"
    # | # - red
    PROMPT_CHAR="\[\e[0;31m\]\$\[\e[m\]"
fi

# | dir - blue
PROMPT_DIR="\[\e[1;34m\]\w\[\e[m\]"

# (ssh) user@host: dir$
PS1="$SSH$NNS$PROMPT_USER$PROMPT_HOST $PROMPT_DIR$PROMPT_CHAR "

# source shared shell environment
if [ -f "$HOME/.shell_env" ]; then
    . ~/.shell_env
fi
