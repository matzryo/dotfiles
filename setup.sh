#!/bin/bash

DOTFILES=(.vimrc .tmux.conf)

for file in ${DOTFILES[@]}
do
  ln -si $HOME/dotfiles/$file $HOME/$file
done

mkdir $HOME/.vim/.backup $HOME/.vim/.swp $HOME/.vim/.undo
