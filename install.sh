#!/bin/bash
# 
# global variable
workspace=$(pwd)

#sudo pacman-mirror -c China

#sudo echo -e '[archlinuxcn]\nSigLevel = Optional TrustedOnly\nServer = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch' >> /etc/pacman.conf

#sudo pacman -Syyu

# initially install
sudo pacman -S xorg i3-gaps polybar dunst fcitx fcitx-rime compton curl \
  zsh wqy-microhei wqy-zenhei gnome-screenshot pulseaudio pulseaudio-alsa \
  pamixer nitrogen lxappearance pavucontrol polkit-gnome fcitx-{gtk2,gtk3,qt4,qt5} \
  pikaur xfce4-terminal nerd-fonts-complete google-chrome visual-studio-code-bin \
  nodejs npm

pikaur -S lux clipit

if [ ! -d $HOME/.config ]; then
  mkdir $HOME/.config
fi

# oh-my-zsh
if [ ! -d $HOME/.oh-my-zsh ]; then
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  if [ $? -ne 0 ]; then
    return 1
  fi
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
  ln -si $workspace/.config/compton.conf $HOME/.config/compton.conf
fi

# dunst
# if [ -d $workspace/.config/dunst ]; then
#  ln -sdi $workspace/.config/dunst $HOME/.config/
# fi

# vim plus
# if [ ! -d $HOME/.vimplus ]; then
#   git clone https://github.com/chxuan/vimplus.git $HOME/.vimplus
#   cd $HOME/.vimplus
#   ./install.sh
#   cd $workspace
# fi

# psw
if [ ! -d $HOME/Repositories ]; then
  mkdir $HOME/Repositories
  git clone https://swwind@github.com/swwind/code.git $HOME/Repositories/code
  ln -si $HOME/Repositories/code/applications/psw.sh $HOME/Applications/psw
fi
