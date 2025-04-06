#!/usr/bin/env sh

# Get the current layout
CURRENT_LAYOUT=$(setxkbmap -query | grep layout | awk '{print $2}')

if [ "$CURRENT_LAYOUT" = "kakutr" ]; then
    setxkbmap -layout "vi"
    notify-send "Keyboard Layout" "Switched to Multitr"
else
    setxkbmap -layout "kakutr"
    notify-send "Keyboard Layout" "Switched to Kakutr"
fi
