#Bradford Smith
#.bashrc
#updated: 5/11/2015
####################

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

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# if ~/bin exists add it to the beginning of the path
if [ -d ~/bin ]; then
	PATH=~/bin:$PATH
fi

# if ~/.scripts exists add it to the path
if [ -d ~/.scripts ]; then
	PATH=$PATH:~/.scripts
fi

# Prompt.
# user@host: dir$
#   | user - green        | @host - bright green  | dir - blue           | $ - green           |
PS1='\[\e[0;32m\]\u\[\e[m\]\[\e[1;32m\]@\h:\[\e[m\] \[\e[1;34m\]\w\[\e[m\]\[\e[0;32m\]\$\[\e[m\] '

# use vim as the default editor
if [ -f /usr/bin/vim ]; then
	export EDITOR=/usr/bin/vim
fi

# for ruby gems
PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"

#if not in SSH
if [ "x${SSH_TTY}" = "x" ]; then
#   and screenfetch is installed
	if [ -f /usr/bin/screenfetch ]; then
		screenfetch
	fi
fi
