#!/bin/sh
# Bradford Smith
# ~/bin/resetPulse.sh
# updated: 04/10/2018
# Force reset PulseAudio

sudo killall pulseaudio
rm -i ~/.config/pulse/*
rm -i ~/.pulse*
