# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

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
    alias ls='ls -G'
    # macOS ARM前提のパス
    export PATH="/opt/homebrew/bin:${PATH}"
    source "$(brew --prefix asdf)"/libexec/asdf.sh
    ;;

  Linux*)
    alias ls='ls --color=auto'
    source "${HOME}"/.asdf/asdf.sh
    ;;
esac

source "$(brew --prefix)/etc/profile.d/z.sh"

# Git管理しない設定(PC固有の設定など)をここに書く
if [ -d "${HOME}/.zsh.d" ] ; then
    for FILE in "${HOME}"/.zsh.d/*.zsh ; do
        source "${FILE}"
    done
    unset FILE
fi

if command -v sheldon >/dev/null 2>&1; then
    eval "$(sheldon source)"
else
    echo "Sheldon(zshのプラグインマネージャ)がインストールされていません。初期化をスキップします。高機能な自動補完やハイライトが効きません。インストールをおすすめします。"
fi

# 設定ファイルの末尾に書く
# https://starship.rs/guide/#%F0%9F%9A%80-installation
eval "$(starship init zsh)"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
