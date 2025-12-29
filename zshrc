

typeset -U path cdpath fpath manpath

path+="$HOME/.zsh/plugins/agkozak-zsh-prompt"
fpath+="$HOME/.zsh/plugins/agkozak-zsh-prompt"
path+="$HOME/.zsh/plugins/formarks"
fpath+="$HOME/.zsh/plugins/formarks"
path+="$HOME/.zsh/plugins/zsh-syntax-highlighting"
fpath+="$HOME/.zsh/plugins/zsh-syntax-highlighting"
path+="$HOME/.zsh/plugins/zsh-abbrev-alias"
fpath+="$HOME/.zsh/plugins/zsh-abbrev-alias"
path+="$HOME/.zsh/plugins/zsh-autopair"
fpath+="$HOME/.zsh/plugins/zsh-autopair"

# Oh-My-Zsh/Prezto calls compinit during initialization,
# calling it twice causes slight start up slowdown
# as all $fpath entries will be traversed again.
autoload -U compinit && compinit

if [[ -f "$HOME/.zsh/plugins/agkozak-zsh-prompt/agkozak-zsh-prompt.plugin.zsh" ]]; then
  source "$HOME/.zsh/plugins/agkozak-zsh-prompt/agkozak-zsh-prompt.plugin.zsh"
fi
if [[ -f "$HOME/.zsh/plugins/formarks/formarks.plugin.zsh" ]]; then
  source "$HOME/.zsh/plugins/formarks/formarks.plugin.zsh"
fi
if [[ -f "$HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "$HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
if [[ -f "$HOME/.zsh/plugins/zsh-abbrev-alias/abbrev-alias.plugin.zsh" ]]; then
  source "$HOME/.zsh/plugins/zsh-abbrev-alias/abbrev-alias.plugin.zsh"
fi
if [[ -f "$HOME/.zsh/plugins/zsh-autopair/autopair.zsh" ]]; then
  source "$HOME/.zsh/plugins/zsh-autopair/autopair.zsh"
fi


# History options should be set in .zshrc and after oh-my-zsh sourcing.
# See https://github.com/nix-community/home-manager/issues/177.
HISTSIZE="1000"
SAVEHIST="1000"

HISTFILE="/home/dgc/.local/share/zsh/history"
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_DUPS
unsetopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
unsetopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY
unsetopt EXTENDED_HISTORY
setopt autocd

source /etc/profile
source $HOME/.profile

# Define key bindings
bindkey '^o' accept-line
bindkey '^j' down-line-or-history
bindkey '^k' up-line-or-history
bindkey '^p' kill-line

#source $HOME/.config/.profile



# Aliases
alias -- 'a'='tmux a || tmux'
alias -- 'clean'='(yes | rm /tmp/* -r) & sudo pacman -Sc'
alias -- 'ed'='emacsclient -a '\''emacs'\'''
alias -- 'gr'='grep -HIrn'
alias -- 'l'='ls -ahl -v --group-directories-first'
alias -- 'la'='ls -ahl -v --group-directories-first'
alias -- 'med'='emacs -q -l ~/.config/minemacs.el'
alias -- 'poweroff'='sudo poweroff'
alias -- 'qed'='emacsclient -nw -a '\''emacs -nw'\'''
alias -- 'reboot'='sudo reboot'
alias -- 'sued'='sudoedit'
alias -- 'update'='sudo pacman -Syu && flatpak update -y'
alias -- 'upoff'='sudo pacman -Syu --noconfirm && flatpak update -y && poweroff'
alias -- 'ytmp3'='yt-dlp -f bestaudio --extract-audio --audio-format mp3 --output "%(title)s.%(ext)s"'

# Named Directory Hashes


ZSH_HIGHLIGHT_HIGHLIGHTERS+=()
