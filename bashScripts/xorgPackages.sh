#!/bin/bash

# Xorg Installation Script for Arch Linux

# Ensure script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root"
    exit 1
fi

# Function to install packages
install_packages() {
    pacman -S --needed "$@" || exit 1
}

echo "Installing Xorg and necessary dependencies..."

# Install Xorg and basic utilities
install_packages xorg-server xorg-xinit xorg-apps

# Install input drivers
install_packages xf86-input-libinput

# Feedback
echo "Xorg installation complete."
