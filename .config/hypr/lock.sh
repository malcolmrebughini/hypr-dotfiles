#!/bin/sh

source $HOME/.config/hypr/load_envs

ring_color="1e1e2e"
key_hl_color="74c7ec"
line_color="74c7ec"
inside_color="45475a"
separator_color="74c7ec"
text_color="74c7ec"
inside_wrong_color="eba0ac"


swaylock --clock --indicator --indicator-radius 100 --indicator-thickness 7 --effect-blur 7x5 \
    --effect-vignette 0.5:0.5 --ring-color $ring_color --key-hl-color $key_hl_color --line-color $line_color \
    --inside-color 24283B88 --separator-color $separator_color --text-color $text_color --inside-wrong-color $inside_wrong_color \
    --grace 2 --fade-in 0.2 --image $WALLPAPER_IMAGE --font "JetBrainsMono Nerd Font"
