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

export PATH="$HOME/.local/bin:$PATH"

# Git管理しない設定(PC固有の設定など)をここに書く
if [ -d "${HOME}/.bash.d" ] ; then
    for f in "${HOME}"/.bash.d/*.sh ; do
        source "$f"
    done
    unset f
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# あればfishを起動
if fish_loc="$(type -p "fish")" && [ -x "$fish_loc" ]; then
  exec $fish_loc
fi
