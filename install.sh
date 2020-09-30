#!/bin/bash

set -e

workspace=$(dirname `realpath "$0"`)

archlinuxcn() {
  echo "===== (1) Add Archlinux CN ====="

  echo -e '[archlinuxcn]\nServer = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch' | sudo tee -a /etc/pacman.conf > /dev/null
  sudo pacman -Syy
  sudo pacman -S archlinuxcn-keyring
}

install() {
  echo "===== (2) Install Packages ====="

  sudo pacman -S xorg i3-gaps polybar dunst fcitx compton xorg-xinit curl \
                 zsh wqy-microhei wqy-zenhei pulseaudio pulseaudio-alsa \
                 pamixer nitrogen lxappearance pavucontrol polkit-gnome fcitx-{gtk2,gtk3,qt4,qt5} \
                 pikaur xfce4-terminal nerd-fonts-complete google-chrome visual-studio-code-bin \
                 nodejs npm flameshot electron-netease-cloud-music git playerctl python-gobject \
                 libsodium xclip

  # pikaur -S lux clipit electron-ssr
}

config() {
  echo "===== (3) Configurations ====="

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

  # vim plus
  # if [ ! -d $HOME/.vimplus ]; then
  #   git clone https://github.com/chxuan/vimplus.git $HOME/.vimplus
  #   cd $HOME/.vimplus
  #   ./install.sh
  #   cd $workspace
  # fi

}

archlinuxcn
install
config

