#!/bin/bash

readonly DOTFILES=(.bashrc .bash_profile .vimrc .tmux.conf .config/fish/config.fish)

for file in ${DOTFILES[@]}
do
  ln -si $HOME/dotfiles/$file $HOME/$file
done

mkdir $HOME/.vim/.backup $HOME/.vim/.swp $HOME/.vim/.undo
