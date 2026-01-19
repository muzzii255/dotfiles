#!/bin/bash

if ! command -v yay &> /dev/null; then
    echo "Installing yay..."
    sudo pacman -S --needed --noconfirm git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm && cd -
fi


PKGS=(
    "zsh" "rofi" "git" "kate" "rust" "go" "postgres" "redis" "alacritty" "zoxide"
    "lazysql" "lazydocker" "csvlens" "yazi" "tmux" "fzf" "bat" "fd" "ripgrep"
)

echo "Installing tools via yay..."
yay -S --needed --noconfirm "${PKGS[@]}"

echo "Installing Zed..."
curl -f https://zed.dev/install.sh | sh

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] && git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
[ ! -d "$ZSH_CUSTOM/plugins/zsh-completions" ] && git clone https://github.com/zsh-users/zsh-completions $ZSH_CUSTOM/plugins/zsh-completions

echo "Download Alacritty themes..."
mkdir -p ~/.config/alacritty/themes
git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes
cp alacritty.toml ~/.config/alacritty/alacritty.toml



echo "Configuring Zed themes..."
mkdir -p ~/.config/zed/theme
git clone https://github.com/muzzii255/zed-transparent /tmp/zed-repo
cp /tmp/zed-repo/*.json ~/.config/zed/theme/
cp settings.json ~/.config/zed/settings.json
cp keymap.json ~/.config/zed/keymap.json


echo "Moving local config files..."
mkdir -p ~/.config/yazi
mkdir -p ~/.config/yazi/flavors
git clone https://github.com/yazi-rs/flavors /tmp/yazi-flavors
cp -r /tmp/yazi-flavors/catppuccin-mocha.yazi ~/.config/yazi/flavors/
cp theme.toml package.toml ~/.config/yazi/


cp .zshrc ~/.zshrc
cp .tmux.conf ~/.tmux.conf

echo "Setting wallpaper..."
WALL_URL="https://github.com/Mikluki/awesome_svg_wallpaper/blob/main/0_pink_planet_dust/pink_explosion_darker_4k.png?raw=true"
curl -L "$WALL_URL" -o ~/wallpaper.png
sudo pacman -S --needed --noconfirm feh
feh --bg-fill ~/wallpaper.png

echo "Starting services..."
sudo systemctl enable --now postgresql
sudo systemctl enable --now redis

echo "Changing Shell..."
chsh -s $(which zsh)
echo "Done! Please run: source ~/.zshrc and relogin..."
