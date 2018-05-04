#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
# >>> BEGIN ADDED BY CNCHI INSTALLER
BROWSER=/usr/bin/chromium
EDITOR=/usr/bin/nano
# <<< END ADDED BY CNCHI INSTALLER

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# anyenv環境変数設定
# bash_profileに書くと、tmux起動時、うまくfishに渡されない
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init - bash)"

# あればfishを起動
if fish_loc="$(type -p "fish")" && [ -x "$fish_loc" ]; then
  exec $fish_loc
fi
