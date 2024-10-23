#!/bin/sh

# Set the background image
feh --bg-scale ~/Pictures/wallpaper.jpg &

# Configure displays
xrandr --output DP-0 --primary --mode 1920x1080 --rate 74.97 --left-of eDP-1-1 --mode 1920x1080 --rate 60.00 &

sleep 1

# Start slstatus
slstatus &
