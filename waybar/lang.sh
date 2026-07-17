#!/usr/bin/env sh

name=$(swaymsg -t get_inputs -r | jq -r '[.[] | select(.type=="keyboard") | .xkb_active_layout_name] | .[0] // empty')

case "$name" in
    "Kakutro")                              echo "kakutr" ;;
    "Multikakutropos based on German")      echo "vi" ;;
    "Russian")                               echo "ru"  ;;
    *)                                        echo "$name" ;;
esac
