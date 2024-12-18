#!/usr/bin/env sh
source /etc/profile

export XDG_CURRENT_DESKTOP=KDE
export XDG_SESSION_DESKTOP=KDE
export SAL_USE_VCLPLUGIN=kde5

cd $HOME

nvidia-settings --assign CurrentMetaMode="nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }"
xrandr --dpi 110

setxkbmap -option caps:swapescape
setxkbmap -layout "kakutr"

emacs --daemon &
playerctld daemon &

dunst &
picom &

/usr/bin/qtile/env/bin/qtile run-cmd -g 1 brave-browser
redshift-gtk -c .config/redshift.conf &

nitrogen --random --set-zoom $HOME/.config/qtile/wallpapers/

pactl set-sink-volume @DEFAULT_SINK@ 25%

#echo " Ran QTile autostart, reached end successfully" >> .log
#$(date +"%r %a %d %h %y)
