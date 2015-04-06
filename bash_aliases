#Bradford Smith
#.bash_aliases
#updated: 4/6/2015
##################

## Overall
##########
alias sudo='sudo ' #allows sudo to work with aliases, the internet says so
alias unmount='umount' #because sometimes I forget

## File Navigation
alias ls='ls --color=auto --group-directories-first'
alias la='ls -lLah'
alias ll='ls -l'
alias grep='grep --color=auto'
alias cdl='cd -' #cd to last directory

## IP Addresses
alias local-ip="ip addr show wlo1 | grep 'inet' | awk '{print \$2}'"
alias public-ip='curl icanhazip.com'

## Laptop Specific
##################
## TLP Powersaving: check to make sure it's running
alias check-tlp="sudo tlp-stat | grep 'TLP_ENABLE\|TLP power save\|power source'"
