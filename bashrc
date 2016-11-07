# Bradford Smith
# ~/.bashrc
# updated: 11/07/2016
#####################

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source global definitions
if [ -f /etc/bash.bashrc ]; then
    . /etc/bash.bashrc
fi

# unset bash_history file
HISTFILE=

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# use vi input mode
set -o vi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# check if we're connected via SSH
if [ "x$SSH_TTY" != "x" ]; then
    SSH="\[\e[0;31m\](ssh) \[\e[m\]"
else
    SSH=""
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
PS1="$SSH$PROMPT_USER$PROMPT_HOST $PROMPT_DIR$PROMPT_CHAR "

# source shared shell environment
if [ -f "$HOME/.shell_env" ]; then
    . ~/.shell_env
fi
