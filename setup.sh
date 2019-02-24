#!/bin/bash

readonly DOTFILES=(
  .bashrc .bash_profile
  .vimrc
  .tmux.conf
  .config/fish/config.fish
  .config/nvim/init.vim
  .config/i3/config
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
