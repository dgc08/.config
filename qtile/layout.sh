#!/usr/bin/env sh

# Get the current layout
CURRENT_LAYOUT=$(setxkbmap -query | grep layout | awk '{print $2}')
case "$CURRENT_LAYOUT" in
    kakutr)
        setxkbmap -layout "vi"
        notify-send "Keyboard Layout" "Switched to Multitr (vi)"
        ;;
    vi)
        setxkbmap -layout "cu"
        notify-send "Keyboard Layout" "Switched to CU"
        ;;
    cu)
        setxkbmap -layout "kakutr"
        notify-send "Keyboard Layout" "Switched to Kakutr"
        ;;
    *)
        setxkbmap -layout "kakutr"
        notify-send "Keyboard Layout" "Defaulted to Kakutr"
        ;;
esac
