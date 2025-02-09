#!/usr/bin/env sh
source /etc/profile

cd $HOME

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

ibus-daemon &
read
