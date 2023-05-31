# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

# If not running interactively, don't do anything
# sshでコマンド実行すると.zshrcが読まれるが、対話シェルではないのでここで終了する
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[%n@%m %1~]$ '
# スクリーンエディタ
export VISUAL=vim
# ラインエディタ
export EDITOR="${VISUAL}"
export PATH="${HOME}/.local/bin:${PATH}"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# OS別設定
# 複雑化した場合ファイルを分割したい
case "$(uname -s)" in
  Darwin*)
    # macOS ARM前提のパス
    export PATH="/opt/homebrew/bin:${PATH}"
    source "$(brew --prefix asdf)"/libexec/asdf.sh
    ;;

  Linux*)
    source "${HOME}"/.asdf/asdf.sh
    ;;
esac

# Git管理しない設定(PC固有の設定など)をここに書く
if [ -d "${HOME}/.zsh.d" ] ; then
    for FILE in "${HOME}"/.zsh.d/*.zsh ; do
        source "${FILE}"
    done
    unset FILE
fi

# あればfishを起動
if FISH_LOC="$(type -p "fish")" && [ -x "${FISH_LOC}" ]; then
  # RubyMineでasdfが読み込まれない問題の対応
  # https://youtrack.jetbrains.com/articles/IDEA-A-19/Shell-Environment-Loading
  if [ -z "$INTELLIJ_ENVIRONMENT_READER" ]; then
    exec "${FISH_LOC}"
  fi
fi

# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
