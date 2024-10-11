#!/bin/bash

# Update package databases and install required packages
sudo pacman -Syu --noconfirm && sudo pacman -S --noconfirm --needed gcc make git ripgrep fd unzip neovim xclip xsel

# Clone the kickstart.nvim repository
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim

# Inform the user about the next step
echo "Running Neovim to continue installation..."

# Wait for 5 seconds
sleep 5

# Launch Neovim
nvim
