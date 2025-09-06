# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
# if [ -n "$BASH_VERSION" ]; then
#     # include .bashrc if it exists
#     if [ -f "$HOME/.bashrc" ]; then
# 	. "$HOME/.bashrc"
#     fi
# fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
# if [ -d "$HOME/.platformio/penv/bin" ] ; then
#     PATH="$HOME/.platformio/penv/bin:$PATH"
# fi
if [ -d "/Library/opt/bin" ] ; then
    PATH="/Library/opt/bin:$PATH"
fi

if [ -f $HOME/.nix-profile/etc/profile.d/nix.sh ];
then
     source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
fi

export XDG_DATA_DIRS=/usr/local/share:/usr/share:$HOME/.local/share:$XDG_DATA_DIRS

export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
export QT_QPA_PLATFORMTHEME=qt5ct
export XIM_PROGRAM="/usr/bin/ibus-daemon -drx"
export EDITOR="emacsclient -n -a emacs -c"
#export QT_STYLE_OVERRIDE=gtk3

[ -f "$HOME/.config/.profile" ] && . "$HOME/.config/.profile"

[ -f "/home/dgc/.ghcup/env" ] && . "/home/dgc/.ghcup/env" # ghcup-env
[ -f "/home/dgc/.cargo/env" ] && . "/home/dgc/.cargo/env" # cargo-env
