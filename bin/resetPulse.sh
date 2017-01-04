#!/bin/sh
#####################
# Reset Pulseaudio
# Bradford Smith
# updated: 01/03/2017
#####################

sudo killall pulseaudio
rm ~/.config/pulse/*
rm ~/.pulse*
