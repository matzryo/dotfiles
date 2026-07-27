#!/usr/bin/env zsh

readonly DOTFILES=(
  .config/herdr/config.toml
  .config/sheldon/plugins.toml
  .config/skhd/skhdrc
  .config/starship.toml
  .config/yabai/yabairc
  .editorconfig
  .vimrc
  .zshrc
)

for file in "${DOTFILES[@]}"
do
  source_file="$(pwd)/$file"
  target_file="$HOME/$file"

  # ディレクトリが無ければ作る
  if [ ! -d "$(dirname "$target_file")" ]; then
    mkdir -p "$(dirname "$target_file")"
  fi

  ln -si "$source_file" "$target_file"
done

# ディレクトリ単位でリンクするもの
readonly DOTDIRS=(
  .config/nvim
)

for dir in "${DOTDIRS[@]}"
do
  source_dir="$(pwd)/$dir"
  target_dir="$HOME/$dir"

  mkdir -p "$(dirname "$target_dir")"

  # リンク元にすでに実ファイルが存在する場合は何もしない
  if [ -e "$target_dir" ] && [ ! -L "$target_dir" ]; then
    echo "skip: $target_dir にディレクトリもしくはファイルが存在します。手動で退避してから再実行してください。"
    continue
  fi

  # 対象が無い or 既存シンボリックリンクの場合。既存リンクは -i で y/n 確認を出す。-h でネスト防止。
  ln -sih "$source_dir" "$target_dir"
done

mkdir -p "$HOME/.vim/.backup" "$HOME/.vim/.swp" "$HOME/.vim/.undo"
