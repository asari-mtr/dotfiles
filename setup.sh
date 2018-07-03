#!/bin/bash

DOT_FILES=( .zsh .zshrc .zshrc.mine .vimrc .lesskey .less .tmux.conf .tigrc .pythonrc .irbrc .ctags .gitconfig .gitignore .curlrc .pyenv)

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done
