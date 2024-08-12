#!/usr/bin/env sh
source /etc/profile

cd $HOME

xrandr --dpi 110
setxkbmap -option caps:swapescape

emacs --daemon &
playerctld daemon &
picom &

/usr/bin/qtile/env/bin/qtile run-cmd -g 1 $HOME/.nix-profile/bin/brave &
redshift-gtk -c .config/redshift.conf &

nitrogen --random --set-zoom $HOME/.config/qtile/wallpapers/

pactl set-sink-volume @DEFAULT_SINK@ 25%

#echo " Ran QTile autostart, reached end successfully" >> .log
#$(date +"%r %a %d %h %y)
