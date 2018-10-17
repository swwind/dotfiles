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

# oh-my-zsh
if [ ! -d ~/.oh-my-zsh ]; then
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
if [ $? -ne 0 ]; then
  return 1
fi
if [ -f $workspace/.zshrc ]; then
  ln -sf $workspace/.zshrc ~/.zshrc
fi

# configure xinitrc
if [ -f $workspace/.xinitrc ]; then
  ln -sf $workspace/.xinitrc ~/.xinitrc
fi

# i3wm
if [ -f $workspace/.config/i3/config ]; then
  ln -sfd $workspace/.config/i3 ~/.config/i3
fi

# polybar
if [ -f $workspace/.config/polybar/config -a -f $workspace/.config/polybar/launch_polybar ]; then
  ln -sfd $workspace/.config/polybar ~/.config/polybar
fi

# compton
if [ -f $workspace/.config/compton.conf ]; then
  ln -sf $workspace/.config/compton.conf ~/.config/compton.conf
fi

# dunst
if [ -f $workspace/.config/dunst/dunstrc ]; then
  ln -sfd $workspace/.config/dunst ~/.config/dunst
fi

