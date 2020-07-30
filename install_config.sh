#!/bin/bash

workspace=$(dirname `realpath "$0"`)

if [ ! -d $HOME/.config ]; then
mkdir $HOME/.config
fi
if [ ! -d $HOME/Applications ]; then
mkdir $HOME/Applications
fi
if [ ! -d $HOME/Repositories ]; then
mkdir $HOME/Repositories
fi

# oh-my-zsh
#if [ ! -d $HOME/.oh-my-zsh ]; then
#  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
#  if [ $? -ne 0 ]; then
#    return 1
#  fi
#fi

ln -sf $workspace/.zshrc $HOME/.zshrc
ln -sf $workspace/.config/compton.conf $HOME/.config/compton.conf
ln -sf $workspace/.xinitrc $HOME/.xinitrc
ln -sfn $workspace/.config/i3 $HOME/.config/
ln -sfn $workspace/.config/polybar $HOME/.config/
ln -sfn $workspace/.config/dunst $HOME/.config/

echo "All linked"
