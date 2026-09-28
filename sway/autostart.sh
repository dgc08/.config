#!/usr/bin/env sh
source /etc/profile

cd $HOME

export QT_QPA_PLATFORMTHEME=qt5ct
export QT_STYLE_OVERRIDE=Breeze

export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

/usr/bin/lxqt-policykit-agent &

killall fcitx5
fcitx5 -d

# killall ibus-daemon
# ibus-daemon -drx &
#ibus start

#nvidia-settings --assign CurrentMetaMode="nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }"
#xrandr --dpi 110

xset s 180 120
xss-lock -n /usr/share/doc/xss-lock/dim-screen.sh -- swaylock -n &

setxkbmap -option caps:swapescape
setxkbmap -layout "kakutr"

killall mako
mako &

killall playerctld
playerctld daemon &

pactl set-sink-volume @DEFAULT_SINK@ 30%
#nitrogen --random --set-zoom $HOME/.config/qtile/wallpapers/

killall picom
picom &

killall redshift
killall redshift-gtk
killall wlsunset
killall gammastep
gammastep -c ~/.config/sway/gammastep.conf
#gammastep -O 3200

#echo " Ran QTile autostart, reached end successfully" >> .log
#$(date +"%r %a %d %h %y)
