#!/bin/bash

sync_with_ignore() {
    for source_file in "${@:1:$#-1}"
    do
        if [[ ! -f $source_file ]] && [[ ! -d $source_file ]]
        then
            return
        fi
    done
    rsync -a "$@" --delete
}

sync_with_ignore ~/.config/alacritty/ ./alacritty
sync_with_ignore ~/.config/nvim/ ./nvim
sync_with_ignore ~/.i3/ ./i3/
sync_with_ignore ~/.Xresources  ./
sync_with_ignore ~/.config/polybar/ ./polybar
sync_with_ignore ~/.config/rofi/ ./rofi
sync_with_ignore ~/.config/dunst/ ./dunst
sync_with_ignore ~/.config/starship.toml ./starship
sync_with_ignore ~/.tmux.conf ~/.tmux.theme ~/tmuxinator.zsh  ./tmux
sync_with_ignore ~/.zshrc ./
