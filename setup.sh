#!/bin/bash

readonly DOTFILES=(
  .asdfrc
  .bashrc
  .bash_profile
  .config/i3/config
  .config/fish/config.fish
  .config/nvim/init.vim
  .config/sheldon/plugins.toml
  .config/skhd/skhdrc
  .config/yabai/yabairc
  .editorconfig
  .tmux.conf
  .vimrc
  .zshrc
)

for file in "${DOTFILES[@]}"
do
  source_file=$HOME/dotfiles/$file
  target_file=$HOME/$file

  # ディレクトリが無ければ作る
  if [ ! -d "$(dirname $target_file)" ]; then
    mkdir -p "$(dirname $target_file)"
  fi

  ln -si "$source_file" "$target_file"
done

mkdir -p "$HOME/.vim/.backup" "$HOME/.vim/.swp" "$HOME/.vim/.undo"
