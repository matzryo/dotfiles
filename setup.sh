#!/usr/bin/env zsh

readonly DOTFILES=(
  .asdfrc
  .config/i3/config
  .config/nvim/init.vim
  .config/sheldon/plugins.toml
  .config/skhd/skhdrc
  .config/starship.toml
  .config/yabai/yabairc
  .editorconfig
  .tmux.conf
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

mkdir -p "$HOME/.vim/.backup" "$HOME/.vim/.swp" "$HOME/.vim/.undo"
