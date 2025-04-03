#!/usr/bin/env sh
source /etc/profile

cd $HOME

export QT_QPA_PLATFORMTHEME=qt5ct
export QT_STYLE_OVERRIDE=Breeze
export KDE_FULL_SESSION=true
export XDG_CURRENT_DESKTOP=KDE

dbus-update-activation-environment --systemd DISPLAY XAUTHORITY QT_QPA_PLATFORMTHEME QT_STYLE_OVERRIDE KDE_FULL_SESSION XDG_CURRENT_DESKTOP

/usr/lib/x86_64-linux-gnu/libexec/polkit-kde-authentication-agent-1 &
ibus-daemon -rxRd

nvidia-settings --assign CurrentMetaMode="nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }"
xrandr --dpi 110

setxkbmap -option caps:swapescape
setxkbmap -layout "kakutr"

dunst &

playerctld daemon &
emacs --daemon &

pactl set-sink-volume @DEFAULT_SINK@ 25%
nitrogen --random --set-zoom $HOME/.config/qtile/wallpapers/

picom &

#echo " Ran QTile autostart, reached end successfully" >> .log
#$(date +"%r %a %d %h %y)
