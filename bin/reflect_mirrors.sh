#!/bin/sh
# Bradford Smith
# ~/bin/reflect_mirrors.sh
# updated: 2018-05-17
# Run reflector on /etc/pacman.d/mirrorlist to keep them up to date

# sanitize PATH variable
PATH=$(command -p getconf PATH)

DEPS="reflector wget"
for d in $DEPS; do
    if ! command -v "$d" >/dev/null 2>&1; then
        echo "$0: requires '$d'"
        exit 1
    fi
done

# check to make sure we are running as root
if ! [ "$(id -u)" = 0 ]; then
    echo "Please run this script as root"
    exit 1
fi

DIR=/etc/pacman.d
MIRRORLIST="$DIR/mirrorlist"
PACNEW="$MIRRORLIST.pacnew"
BACKUP="$MIRRORLIST.backup"
URL=https://www.archlinux.org/mirrorlist/all/

err=0

# remove mirrorlist.pacnew if it exists
if [ -f "$PACNEW" ]; then
    rm "$PACNEW"
fi

# backup old mirrorlist
mv "$MIRRORLIST" "$BACKUP"

# get new mirrorlist from archlinux.org
if wget -q -O "$MIRRORLIST" "$URL" ; then

    # run reflector to sort mirrors by fastest 200 USA mirrors
    if reflector -c 'United States' -l 200 --sort rate --save "$MIRRORLIST" ; then
        echo "Reflector updated mirrorlist successfully"
    else
        echo "Reflector failed, replacing old mirrorlist" 1>&2
        err=1
    fi
else
    echo "Wget failed, replacing old mirrorlist" 1>&2
    err=1
fi

# on error copy back the backed-up mirrorlist
if [ $err -eq 1 ]; then
    cp "$BACKUP" "$MIRRORLIST"
fi
