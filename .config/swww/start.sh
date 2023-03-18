#!/bin/sh

# load $WALLPAPER_IMAGE environment variable
source $HOME/.config/hypr/load_envs

function load_wp(){
    swww img -t any --transition-bezier 0.0,0.0,1.0,1.0 --transition-duration .8 --transition-step 255 --transition-fps 144 $WALLPAPER_IMAGE
}

#perform cleanup and exit
if ! swww query; then
    swww init
fi

load_wp
