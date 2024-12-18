#!/usr/bin/env sh

# Get the current layout
CURRENT_LAYOUT=$(setxkbmap -query | grep layout | awk '{print $2}')

if [ "$CURRENT_LAYOUT" = "kakutr" ]; then
    setxkbmap -layout "ru" -variant "phonetic"
else
    setxkbmap -layout "kakutr"
fi
