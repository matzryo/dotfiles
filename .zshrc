# 引数で指定されたディレクトリにあるzsh設定ファイルを読み込む
# 例: load_custom_config "${HOME}/.zsh.d"
load_custom_config() {
    local dir="$1"
    if [ -d "$dir" ]; then
        for file in "$dir"/*.zsh; do
            source "$file"
        done
    fi
}

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

if command -v sheldon >/dev/null 2>&1; then
    eval "$(sheldon source)"
else
    echo "Sheldon(zshのプラグインマネージャ)がインストールされていません。初期化をスキップします。高機能な自動補完やハイライトが効きません。インストールをおすすめします。"
fi

# Git管理しない設定(PC固有の設定など)をここに書く
load_custom_config "${HOME}/.zsh.d"

# 設定ファイルの末尾に書く
# https://starship.rs/guide/#%F0%9F%9A%80-installation
eval "$(starship init zsh)"

# Git管理しない設定(PC固有の設定など)をここに書く
# とくに、末尾に書くように指定されているものを書く
load_custom_config "${HOME}/.zsh.post.d"
