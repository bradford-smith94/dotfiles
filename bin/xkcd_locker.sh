#!/bin/bash
# credit: reddit.com/u/NotoriousHakk0r4chan

wget $(curl -sL "http://dynamic.xkcd.com/random/comic/" | grep "http://imgs.xkcd.com/comics/" |  awk '{print $5}') -O /tmp/xkcd.png
ICON=/tmp/xkcd.png
TMPBG=/tmp/screen.png
scrot $TMPBG
convert $TMPBG -scale 10% -scale 1000% $TMPBG

PX=0
PY=0
# lockscreen image info
R=$(file $ICON | grep -o '[0-9]* x [0-9]*')
RX=$(echo $R | cut -d' ' -f 1)
RY=$(echo $R | cut -d' ' -f 3)
SR=$(xrandr --query | grep ' connected' | cut -f4 -d' ')
for RES in $SR
  do
    # monitor position/offset
    SRX=$(echo $RES | cut -d'x' -f 1)                   # x pos
    SRY=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 1)  # y pos
    SROX=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 2) # x offset
    SROY=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 3) # y offset
    PX=$(($SROX + $SRX / 2 - $RX / 2))
    PY=$(($SROY + $SRY / 2 - $RY / 2))

    convert $TMPBG $ICON -geometry +$PX+$PY -composite -matte $TMPBG
done

i3lock -i $TMPBG -I 5

rm $TMPBG
rm $ICON
