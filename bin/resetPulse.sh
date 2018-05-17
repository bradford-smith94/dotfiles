#!/bin/sh
# Bradford Smith
# ~/bin/resetPulse.sh
# updated: 2018-05-13
# Force reset PulseAudio

# sanitize PATH variable
PATH=$(command -p getconf PATH)

sudo killall pulseaudio
rm -i ~/.config/pulse/*
rm -i ~/.pulse*
