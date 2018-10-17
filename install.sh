#!/bin/bash
# 
# global variable
workspace=$(pwd)

# initially install
sudo pacman -S xorg-xinit i3-gaps polybar dunst fcitx fcitx-rime compton curl \
  zsh

if [ $? -ne 0 ]; then
  return 1
fi

if [ ! -d $HOME/.config ]; then
  mkdir $HOME/.config
fi

# oh-my-zsh
if [ ! -d $HOME/.oh-my-zsh ]; then
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
if [ $? -ne 0 ]; then
  return 1
fi
if [ -f $workspace/.zshrc ]; then
  ln -si $workspace/.zshrc $HOME/.zshrc
fi

# configure xinitrc
if [ -f $workspace/.xinitrc ]; then
  ln -si $workspace/.xinitrc $HOME/.xinitrc
fi

# i3wm
if [ -d $workspace/.config/i3 ]; then
  ln -sdi $workspace/.config/i3 $HOME/.config/
fi

# polybar
if [ -d $workspace/.config/polybar ]; then
  ln -sdi $workspace/.config/polybar $HOME/.config/
fi

# compton
if [ -f $workspace/.config/compton.conf ]; then
  ln -sf $workspace/.config/compton.conf $HOME/.config/compton.conf
fi

# dunst
if [ -d $workspace/.config/dunst ]; then
  ln -sdi $workspace/.config/dunst $HOME/.config/
fi

