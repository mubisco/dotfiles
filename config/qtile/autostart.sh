#!/bin/sh

# rearrange keyboard map
setxkbmap -layout us -variant altgr-intl

# rearrange three monitors
#xrandr --output DP-0 --auto --output DP-2 --auto --left-of DP-0 --output DP-4 --auto --right-of DP-0

#xrandr --output eDP1 --auto --output HDMI1 --auto --right-of eDP1
xrandr --output eDP1 --auto --output HDMI1 --auto --right-of eDP1 --output DP1 --auto --right-of HDMI1

# systray volume
volumeicon &

# cbatticon -u 300 &
