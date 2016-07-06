# Bradford Smith
# .bashrc
# updated: 07/06/2016
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

# Prompt.
# user@host: dir$
if [[ $EUID -ne 0 ]]; then
    #if not root
    #   | user - green        | @host - bright green  | dir - blue           | $ - green           |
    PS1='\[\e[0;32m\]\u\[\e[m\]\[\e[1;32m\]@\h:\[\e[m\] \[\e[1;34m\]\w\[\e[m\]\[\e[0;32m\]\$\[\e[m\] '
else
    #else root
    #   | user - red          | @host - bright red    | dir - blue           | # - red             |
    PS1='\[\e[0;31m\]\u\[\e[m\]\[\e[1;31m\]@\h:\[\e[m\] \[\e[1;34m\]\w\[\e[m\]\[\e[0;31m\]\$\[\e[m\] '
fi

# source shared shell environment
if [ -f "$HOME/.shell_env" ]; then
    . ~/.shell_env
fi
