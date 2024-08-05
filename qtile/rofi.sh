#!/usr/bin/env sh

source /etc/profile
source ~/.profile

export PATH=/home/dgc/.nix-profile/bin:/nix/var/nix/profiles/default/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/home/dgc/.zsh/plugins/agkozak-zsh-prompt:/home/dgc/.zsh/plugins/formarks:/home/dgc/.zsh/plugins/zsh-syntax-highlighting:/home/dgc/.zsh/plugins/zsh-abbrev-alias:/home/dgc/.zsh/plugins/zsh-autopair:$PATH
export XDG_DATA_DIRS=/home/dgc/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share:/home/dgc/.nix-profile/share:/nix/var/nix/profiles/default/share:$XDG_DATA_DIRS
source /home/dgc/.nix-profile/etc/profile.d/hm-session-vars.sh

/usr/bin/rofi -show combi -combi-modi "window,drun,run"
