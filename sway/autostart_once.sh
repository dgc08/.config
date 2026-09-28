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
swaymsg "workspace 6:u; exec alacritty -T 'btop' -e /usr/bin/btop" &
swaymsg "workspace 2:2; exec emacsclient -c" &
swaymsg "workspace 8:o; exec spotify-launcher" &
swaymsg "workspace 1:1; exec brave --ozone-platform=wayland --password-store=basic" &
#swaymsg "workspace 3:3; exec vesktop --disable-features=WebRtcAllowInputVolumeAdjustment" &
#/usr/bin/discord --disable-features=WebRtcAllowInputVolumeAdjustment ELECTRON_OZONE_PLATFORM_HINT=x11  &
#/usr/bin/discord --enable-features=UseOzonePlatform --ozone-platform=wayland --disable-features=WebRtcAllowInputVolumeAdjustment &
