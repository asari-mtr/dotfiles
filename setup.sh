#!/usr/bin/env bash
DOT_FILES=(.zsh .zshrc .zprofile .zshenv .vimrc .lesskey .less .tmux.conf .tigrc .pythonrc .inputrc .irbrc .ctags .gitconfig)

case ${OSTYPE} in
  darwin*)
    DOT_FILES=(Brewfile "${DOT_FILES[@]}")
    ;;
esac

for file in ${DOT_FILES[@]}
do
  if [[ -e $HOME/$file ]]; then
    echo "File exists $file"
  else
    ln -s $HOME/dotfiles/$file $HOME/$file
    echo "File created $file"
  fi
done

mkdir -p ~/.config/nvim

ln -s $HOME/dotfiles/init.vim $HOME/.config/nvim/init.vim

ln -s $HOME/dotfiles/powerline $HOME/.config/powerline

# Install anyanv
if [[ ! -e $HOME/.anyenv ]]; then
  git clone https://github.com/riywo/anyenv ~/.anyenv
  echo -e "Installed anyenv to ~/.anyenv"
fi
