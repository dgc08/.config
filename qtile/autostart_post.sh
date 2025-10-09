#!/usr/bin/env sh

# Emacs daemon has to go into the autostart_once, because
# 1. It needs the X11 context so it can't be a systemd service
# 2. I don't want it to kill all my emacs processes when I reload my qtile config
killall emacs
emacs --daemon &

qtile run-cmd -g 1 brave --pasword-store=basic &

qtile run-cmd -g 2 emacsclient -c &
qtile run-cmd -g 3 vesktop &

qtile run-cmd -g m easyeffects &

qtile run-cmd -g u pwvucontrol &
qtile run-cmd -g u alacritty -e "/usr/bin/btop" &

qtile run-cmd -g 1 alacritty -e bash -c "echo Available updates:; /usr/bin/checkupdates; cat" &
