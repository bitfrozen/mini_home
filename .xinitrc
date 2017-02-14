#!/bin/sh

# Mandatorily source xinitrc-common, which is common code shared between the
# Xsession and xinitrc scripts which has been factored out to avoid duplication
. /etc/X11/xinit/xinitrc-common

# Adding date and time display to dwm status line
while true; do xsetroot -name "$(date +"%F %R" )";sleep 1m;done &

# Set keyboard repeat settings
xset r rate 200 40

# Start our window manager
exec dwm

