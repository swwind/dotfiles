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

  sudo pacman -S --noconfirm \
    xorg picom xorg-xinit curl awesome git rofi zsh pikaur \
    wqy-microhei wqy-zenhei nerd-fonts-complete \
    pulseaudio pulseaudio-alsa pamixer playerctl \
    nitrogen lxappearance pavucontrol polkit-gnome \
    xfce4-terminal google-chrome visual-studio-code-bin \
    nodejs npm flameshot electron-netease-cloud-music libsodium xclip \
    fcitx5 fcitx5-gtk fcitx5-qt fcitx5-chinese-addons fcitx5-configtool \
    fcitx5-material-color fcitx5-pinyin-moegirl fcitx5-pinyin-zhwiki \
    thunar gvfs tumbler thunar-volman thunar-archive-plugin thunar-media-tags-plugin \
    capitaine-cursors papirus-icon-theme arc-gtk-theme \
    networkmanager network-manager-applet \
    proxychains-ng telegram-desktop redshift brightnessctl pulsemixer

  # oh-my-zsh
  if [ ! -d $HOME/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://cdn.jsdelivr.net/gh/robbyrussell/oh-my-zsh/tools/install.sh)"
  fi

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

  ln -sf $workspace/.zshrc $HOME/.zshrc
  ln -sf $workspace/.pam_environment $HOME/.pam_environment
  ln -sf $workspace/.config/picom.conf $HOME/.config/picom.conf
  ln -sf $workspace/.xinitrc $HOME/.xinitrc
  ln -sfn $workspace/.config/awesome $HOME/.config/

  echo "===== (3) Configurations ${GREEN}Success${NC} ====="

}

echo "awesome wm installer"

archlinuxcn
install
config

