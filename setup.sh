#!/bin/bash
DOT_FILES=(.zsh .zshrc .zprofile .zshenv .vimrc .lesskey .less .tmux.conf .tigrc .pythonrc .inputrc .irbrc .ctags .gitconfig .gitignore .curlrc .pyenv)

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done
