#!/bin/bash

DOT_FILES=( .zshrc .zshrc.mine .vimrc .lesskey .less .tmux.conf .tigrc .irbrc .ctags .gitconfig .curlrc)

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done
