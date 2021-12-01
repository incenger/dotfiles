rsync -a ~/.config/alacritty/ ./alacritty --delete
rsync -a ~/.config/nvim/ ./nvim --delete
rsync -a ~/.i3/ ./i3/ --delete
rsync -a ~/.Xresources  ./
rsync -a ~/.config/polybar/ ./polybar --delete
rsync -a ~/.config/rofi/ ./rofi --delete
rsync -a ~/.config/dunst/ ./dunst --delete
rsync -a ~/.config/starship.toml ./starship --delete
rsync -a ~/.tmux.conf ~/.tmux.theme ~/tmuxinator.zsh  ./tmux
rsync -a ~/.zshrc ./
