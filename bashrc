# Bradford Smith
# ~/.bashrc
# updated: 10/22/2016
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

# Prompt.
# user@host: dir$
if [[ $EUID -ne 0 ]]; then
    #if not root
    #   | ssh | user - green        | @host - bright green  | dir - blue           | $ - green           |
    PS1="$SSH\[\e[0;32m\]\u\[\e[m\]\[\e[1;32m\]@\h:\[\e[m\] \[\e[1;34m\]\w\[\e[m\]\[\e[0;32m\]\$\[\e[m\] "
else
    #else root
    #   | ssh | user - red          | @host - bright red    | dir - blue           | # - red             |
    PS1="$SSH\[\e[0;31m\]\u\[\e[m\]\[\e[1;31m\]@\h:\[\e[m\] \[\e[1;34m\]\w\[\e[m\]\[\e[0;31m\]\$\[\e[m\] "
fi

# source shared shell environment
if [ -f "$HOME/.shell_env" ]; then
    . ~/.shell_env
fi
