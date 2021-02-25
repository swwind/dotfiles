#!/bin/bash

set -e

workspace=$(dirname `realpath "$0"`)

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

archlinuxcn() {
  echo "===== (1) Add Archlinux CN ====="

  read skip -p "Continue? [Y/n] "
  if [[ $skip -eq n ]]; then
    echo "===== (1) Add Archlinux CN ${RED}Skiped${NC} ====="
    return
  fi

  echo -e '[archlinuxcn]\nServer = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch' | sudo tee -a /etc/pacman.conf > /dev/null
  sudo pacman -Syy
  sudo pacman -S --noconfirm archlinuxcn-keyring

  echo "===== (1) Add Archlinux CN ${GREEN}Success${NC} ====="
}

install() {
  echo "===== (2) Install Packages ====="

  read skip -p "Continue? [Y/n] "
  if [[ $skip -eq n ]]; then
    echo "===== (2) Install Packages ${RED}Success${NC} ====="
    return
  fi

  sudo pacman -S --noconfirm xorg i3-gaps polybar dunst picom xorg-xinit curl \
                 zsh wqy-microhei wqy-zenhei pulseaudio pulseaudio-alsa \
                 pamixer nitrogen lxappearance pavucontrol polkit-gnome \
                 pikaur xfce4-terminal nerd-fonts-complete google-chrome visual-studio-code-bin \
                 nodejs npm flameshot electron-netease-cloud-music git playerctl python-gobject \
                 libsodium xclip \
                 fcitx5 fcitx5-gtk fcitx5-qt fcitx5-chinese-addons fcitx5-configtool

  # pikaur -S lux clipit electron-ssr
  echo "===== (2) Install Packages ${GREEN}Success${NC} ====="
}

config() {
  echo "===== (3) Configurations ====="

  read skip -p "Continue? [Y/n] "
  if [[ $skip -eq n ]]; then
    return
  fi

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
  if [ ! -d $HOME/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://cdn.jsdelivr.net/gh/robbyrussell/oh-my-zsh/tools/install.sh)"
  fi

  ln -sf $workspace/.zshrc $HOME/.zshrc
  ln -sf $workspace/.config/picom.conf $HOME/.config/picom.conf
  ln -sf $workspace/.xinitrc $HOME/.xinitrc
  ln -sfn $workspace/.config/i3 $HOME/.config/
  ln -sfn $workspace/.config/polybar $HOME/.config/
  ln -sfn $workspace/.config/dunst $HOME/.config/

  echo "===== (3) Configurations ${GREEN}Success${NC} ====="

}

echo "i3wm installer"

archlinuxcn
install
config

