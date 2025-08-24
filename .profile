if command -v rg >/dev/null 2>&1; then
  alias gr='rg --vimgrep'
else
  alias gr='grep -IHrn'
fi

alias -- 'a'='tmux a || tmux'
alias -- 'clean'='(yes | rm /tmp/* -r)'
alias -- 'ed'='emacsclient -a '\''emacs'\'''
alias -- 'l'='ls -ahl --group-directories-first'
alias -- 'la'='ls -ahl -v --group-directories-first'
alias -- 'med'='emacs -q -l ~/.config/minemacs.el'
alias -- 'poweroff'='sudo poweroff'
alias -- 'qed'='emacsclient -nw -a '\''emacs -nw'\'''
alias -- 'reboot'='sudo reboot'
alias -- 'sued'='sudoedit'
alias -- 'sys-update'='sudo apt update && sudo apt upgrade && sudo apt autoremove'
alias -- 'update'='home-manager switch'
alias -- 'ytmp3'='yt-dlp -f bestaudio --extract-audio --audio-format mp3 --output "%(title)s.%(ext)s"'

if [ -d "/Library/opt/bin" ] ; then
    PATH="/Library/opt/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
