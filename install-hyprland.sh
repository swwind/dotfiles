#!/bin/bash

set -e

workspace=$(dirname `realpath "$0"`)

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

archlinuxcn() {
  echo "===== (1) Add Archlinux CN ====="

  read -p "Continue? [Y/n] " skip
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

  read -p "Continue? [Y/n] " skip
  if [[ $skip -eq n ]]; then
    echo "===== (2) Install Packages ${RED}Success${NC} ====="
    return
  fi

  sudo pacman -S --noconfirm \
    paru kitty wofi slurp grim network-manager-applet \
    dunst light playerctl wl-clipboard swaylock-effects

  paru -S --noconfirm \
    hyprland-git hyprpaper-git waybar-hyprland

  # oh-my-zsh
  #if [ ! -d $HOME/.oh-my-zsh ]; then
  #  sh -c "$(curl -fsSL https://cdn.jsdelivr.net/gh/robbyrussell/oh-my-zsh/tools/install.sh)"
  #fi

  echo "===== (2) Install Packages ${GREEN}Success${NC} ====="
}

config() {
  echo "===== (3) Configurations ====="

  read -p "Continue? [Y/n] " skip
  if [[ $skip -eq n ]]; then
    return
  fi

  if [ ! -d $HOME/.config ]; then
    mkdir $HOME/.config
  fi

  cat $workspace/.zshrc >> $HOME/.zshrc
  ln -sf $workspace/.pam_environment $HOME/.pam_environment
  ln -sfn $workspace/.config/hypr $HOME/.config/
  ln -sfn $workspace/.config/waybar $HOME/.config/
  ln -sfn $workspace/.config/dunst $HOME/.config/

  echo "===== (3) Configurations ${GREEN}Success${NC} ====="
}

echo "# hyprland wm installer"

archlinuxcn
install
config

echo "Installation finished"
echo "But you still need to install dm and other things like fcitx your self"
