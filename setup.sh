#!/bin/bash

readonly DOTFILES=(.bashrc .bash_profile .vimrc .tmux.conf)

for file in ${DOTFILES[@]}
do
  ln -si $HOME/dotfiles/$file $HOME/$file
done

readonly NESTED_DOTFILES=(.config/fish/config.fish)

for file in ${NESTED_DOTFILES[@]}
do
  source_file=$HOME/dotfiles/$file
  target_file=$HOME/$file

  mkdir -p $(dirname $target_file) && touch $target_file
  ln -si $source_file $target_file
done

mkdir -p $HOME/.vim/.backup $HOME/.vim/.swp $HOME/.vim/.undo
