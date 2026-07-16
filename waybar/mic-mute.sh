#!/usr/bin/env bash
# Translated from qtile's mic_status() function.
# Prints a muted-mic glyph when the default source is muted, nothing otherwise.

status=$(pactl get-source-mute @DEFAULT_SOURCE@)

if echo "$status" | grep -qi yes; then
    echo "🔇"
else
    echo "󰍬"
fi
