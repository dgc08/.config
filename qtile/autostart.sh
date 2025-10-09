#!/usr/bin/env sh
source /etc/profile

cd $HOME

export QT_QPA_PLATFORMTHEME=qt5ct
export QT_STYLE_OVERRIDE=Breeze

/usr/bin/lxqt-policykit-agent &

killall ibus-daemon
ibus-daemon -rxRd &

#nvidia-settings --assign CurrentMetaMode="nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }"
xrandr --dpi 110

xset s 180 120
xss-lock -n /usr/share/doc/xss-lock/dim-screen.sh -- i3lock -n &

setxkbmap -option caps:swapescape
setxkbmap -layout "kakutr"

killall dunst
dunst &

killall playerctld
playerctld daemon &

killall greenclip
greenclip daemon &

pactl set-sink-volume @DEFAULT_SINK@ 25%
nitrogen --random --set-zoom $HOME/.config/qtile/wallpapers/

killall picom
picom &

killall redshift
killall redshift-gtk
redshift-gtk -c .config/redshift.conf &


#echo " Ran QTile autostart, reached end successfully" >> .log
#$(date +"%r %a %d %h %y)
