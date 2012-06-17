#!/bin/bash

DOT_FILES=( .zshrc .zshrc.mine .vimrc .tmux.conf .tigrc .irbrc .ctags .gitconfig)

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done
