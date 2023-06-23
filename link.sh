#!/bin/sh

echo $PWD
echo $XDG_CONFIG_HOME
echo $HOME

CFG_TO_LINK=("alacritty" "dunst" "eww" "hypr" "nushell" "rofi" "swww" "starship.toml")
DIR_TO_LINK=(".fonts" ".wallpapers" ".icons")
CONFIG_DIR="$HOME/.config"
RUN_TS=$(date +"%s")


for cfg in "${CFG_TO_LINK[@]}"; do
    echo "Linking $cfg"

    bak_path="$CONFIG_DIR/$cfg.bak.$RUN_TS"
    exists=false

    if [ -f "$CONFIG_DIR/$cfg" ]; then
        exists=true
    elif [ -d "$CONFIG_DIR/$cfg" ]; then
        exists=true
    fi

    if [ "$exists" = true ]; then
        echo "$cfg config exists. Backing up to $bak_path"
        mv "$CONFIG_DIR/$cfg" $bak_path
    fi

    ln -s "$PWD/.config/$cfg" "$CONFIG_DIR/$cfg"

    echo "$cfg done"
done

for dir in "${DIR_TO_LINK[@]}"; do
    echo "Linking $dir"

    bak_path="$HOME/$dir.bak.$RUN_TS"
    exists=false

    if [ -f "$HOME/$dir" ]; then
        exists=true
    elif [ -d "$HOME/$dir" ]; then
        exists=true
    fi

    if [ "$exists" = true ]; then
        echo "$dir config exists. Backing up to $bak_path"
        mv "$HOME/$dir" $bak_path
    fi

    ln -s "$PWD/$dir" "$HOME/$dir"

    echo "$dir done"
done

ln -s "$PWD/.config/nvim" "$HOME/.config/nvim/lua/user"


echo "Linking hyprstart.sh"

sudo ln -s "$PWD/hyprstart.sh" /usr/bin/hyprstart.sh

