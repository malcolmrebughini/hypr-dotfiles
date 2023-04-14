#!/bin/sh

cd ~

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# Log WLR errors and logs to the hyprland log. Recommended
export HYPRLAND_LOG_WLR=1

# Tell XWayland to use a cursor theme
export XCURSOR_THEME=Bibata-Modern-Classic

# Set a cursor size
export XCURSOR_SIZE=24

# Example IME Support: fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export SDL_IM_MODULE=fcitx
export GLFW_IM_MODULE=ibus

export LIBVA_DRIVER_NAME=nvidia
export XDG_SESSION_TYPE=wayland
export GBM_BACKEND=nvidia-drm
# export __GLX_VENDOR_LIBRARY_NAME=nvidia
export WLR_NO_HARDWARE_CURSORS=1

# v = vertical 
# h = horizontal
export BAR_ORIENTATION="h"


if [[ $BAR_ORIENTATION = "v" ]]
then
    export TOP_RESERVED="0"
    export LEFT_RESERVED="50"
    export BAR_EWW="leftbar"
else
    export TOP_RESERVED="37"
    export LEFT_RESERVED="0"
    export BAR_EWW="topbar"
fi


exec Hyprland
