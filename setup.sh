#!/bin/sh

curr=$PWD

# Install aur helper
sudo pacman -S --needed base-devel
cd /tmp
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd $curr

# Base
sudo pacman -S netctl gnome-keyring alacritty nushell starship zoxide rustup \ 
  grim polkit-kde-agent dunst pamixer libpulse xdg-desktop-portal wireplumber socat \ 
  nvidia-dkms slurp papirus-icon-theme socat nvidia-dkms firefox thunar \
  pipewire-pulse pipewire pipewire-jack helvum dmenu mypaint spotify \
  ttf-fira-code ttf-jetbrains-mono adobe-source-han-sans-jp-fonts font-manager \
  fzf bluez bluez-utils ristretto neovim wl-clipboard ffmpegthumbnailer unarchiver \
  jq poppler fd ripgrep xdg-desktop-portal-hyprland hyprland mpv silicon rofi-wayland \
  hypridle

paru -S eww swww yazi-git swaylock-effects bibata-cursor-theme \
  ttf-material-design-icons xwaylandvideobridge-bin wayshot brillo


# Desktop Only
sudo pacman -S telegram-desktop reaper 
paru -S jellyfin discord-screenaudio 


# Create symlinks
./link.sh


# Reload font cache
fc-cache -r
