## File Navigation
alias ls='ls --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias cdl='cd -'
alias la='ls -lLah'
alias ll='ls -l'
alias sudo='sudo ' #allows sudo to work with aliases

## TLP Powersaving
alias check-tlp="sudo tlp-stat | grep 'TLP_ENABLE\|TLP power save\|power source'"

## IP Addresses
alias local-ip="ip addr show wlo1 | grep 'inet' | awk '{print \$2}'"
alias public-ip='curl icanhazip.com'
