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

# XDG Base Directory
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# OS別設定
# 複雑化した場合ファイルを分割したい
case "$(uname -s)" in
  Darwin*)
    alias ls='ls -G'
    # macOS ARM前提のパス
    export PATH="/opt/homebrew/bin:${PATH}"
    [ -f "$(brew --prefix)/etc/profile.d/z.sh" ] && source "$(brew --prefix)/etc/profile.d/z.sh"
    ;;

  Linux*)
    alias ls='ls --color=auto'
    ;;
esac

# tmux自動起動（tmuxセッション内でなければ新規セッションを起動）
if command -v tmux >/dev/null 2>&1 && [ -z "$TMUX" ]; then
    tmux new-session
fi

if command -v sheldon >/dev/null 2>&1; then
    eval "$(sheldon source)"
else
    echo "Sheldon(zshのプラグインマネージャ)がインストールされていません。初期化をスキップします。高機能な自動補完やハイライトが効きません。インストールをおすすめします。"
fi

eval "$(mise activate zsh)"

# 補完機能を有効にする
autoload -Uz compinit && compinit

# Emacsキーバインドを常に有効化
# EDITOR=vimのため、未指定だとkeymapsがviinsになる
bindkey -e

# Git管理しない設定(PC固有の設定など)をここに書く
load_custom_config "${HOME}/.zsh.d"

# git switch **[TAB] でブランチ名を補完する
# @see https://github.com/junegunn/fzf/wiki/Examples-(completion)#zsh-complete-git-co-for-example
_fzf_complete_git() {
    ARGS="$@"
    local branches
    branches=$(git branch -vv --all)
    if [[ $ARGS == 'git switch'* ]]; then
        _fzf_complete --reverse --multi -- "$@" < <(
            echo $branches
        )
    else
        eval "zle ${fzf_default_completion:-expand-or-complete}"
    fi
}

_fzf_complete_git_post() {
    awk '{print $1}'
}

# fsw - branch/tagにswitchする。HEADとのコミット差分をプレビューしながら選べる。
# @see https://github.com/junegunn/fzf/wiki/Examples#git
fsw() {
  local tags branches target
  branches=$(
    git --no-pager branch --all \
      --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" \
    | sed '/^$/d') || return
  tags=$(
    git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}') || return
  target=$(
    (echo "$branches"; echo "$tags") |
    fzf --no-hscroll --no-multi -n 2 \
        --ansi --preview="git --no-pager log -150 --pretty=format:%s '..{2}'") || return
  git switch $(awk '{print $2}' <<<"$target" )
}

# 設定ファイルの末尾に書く
# https://starship.rs/guide/#%F0%9F%9A%80-installation
eval "$(starship init zsh)"

# Git管理しない設定(PC固有の設定など)をここに書く
# とくに、末尾に書くように指定されているものを書く
load_custom_config "${HOME}/.zsh.post.d"
