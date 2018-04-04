[ -f ~/.xprofile ] && . ~/.xprofile

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets)

xsetroot -cursor_name left_ptr
feh --bg-scale ~/Pictures/background.lnk
#compton&
sxhkd&
udiskie&
exec bspwm
