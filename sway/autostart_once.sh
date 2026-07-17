#!/usr/bin/env sh

# killall emacs
# emacs --daemon &

# swaymsg "workspace 6:u"
# exec ./i3-toolwait pwvucontrol &
# echo here 1

# swaymsg "workspace 6:u"
# exec ./i3-toolwait -- alacritty -e '/usr/bin/btop'

# swaymsg "workspace 2:2"
# exec ./i3-toolwait -- emacsclient -c &

# swaymsg "workspace 1:1"
# exec ./i3-toolwait -- brave --pasword-store=basic &

# swaymsg "workspace 3:3"
# exec ./i3-toolwait -- vesktop --disable-features=WebRtcAllowInputVolumeAdjustment &

swaymsg "workspace 6:u; exec pwvucontrol" &
swaymsg "workspace 6:u; exec alacritty -e /usr/bin/btop" &
swaymsg "workspace 2:2; exec emacsclient -c" &
swaymsg "workspace 1:1; exec brave --password-store=basic" &
swaymsg "workspace 3:3; exec vesktop --disable-features=WebRtcAllowInputVolumeAdjustment" &
