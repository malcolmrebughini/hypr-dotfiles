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
sudo pacman -S netctl gnome-keyring alacritty nushell starship zoxide rustup grim flameshot polkit-kde-agent dunst pamixer libpulse xdg-desktop-portal wireplumber socat nvidia-dkms swayidle slurp papirus-icon-theme socat nvidia-dkms firefox thunar pipewire-pulse pipewire pipewire-jack helvum rofi dmenu mypaint spotify ttf-fira-code ttf-jetbrains-mono adobe-source-han-sans-jp-fonts 
paru -S eww-wayland swww vscodium-bin greetd greetd-wlgreet xdg-desktop-portal-hyprland-git swaylock-effects hyprland-nvidia-git spotify bibata-cursor-theme


# Desktop Only
sudo pacman -S telegram-desktop vlc reaper 
paru -S jellyfin webcord 


# Create symlinks
./link.sh


# Reload font cache
fc-cache -r
