#
# ~/.bashrc
#

# If not running interactively, don't do anything
# sshでコマンド実行すると.bashrcが読まれるが、対話シェルではないのでここで終了する
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
# スクリーンエディタ
export VISUAL=vim
# ラインエディタ
export EDITOR="${VISUAL}"
export PATH="$HOME/.local/bin:$PATH"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# OS別設定
# 複雑化した場合ファイルを分割したい
case "$(uname -s)" in
  Darwin*)
    export PATH="/opt/homebrew/bin:${PATH}"
    . $(brew --prefix asdf)/asdf.sh
    . $(brew --prefix asdf)/etc/bash_completion.d/asdf.bash
    ;;

  Linux*)
    . "${HOME}"/.asdf/asdf.sh
    . "${HOME}"/.asdf/completions/asdf.bash
    ;;
esac

# Git管理しない設定(PC固有の設定など)をここに書く
if [ -d "${HOME}/.bash.d" ] ; then
    for f in "${HOME}"/.bash.d/*.sh ; do
        source "$f"
    done
    unset f
fi

# あればfishを起動
if fish_loc="$(type -p "fish")" && [ -x "$fish_loc" ]; then
  exec $fish_loc
fi
