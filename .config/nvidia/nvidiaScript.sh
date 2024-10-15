#!/bin/bash

# NVIDIA Driver Installation Script for Arch Linux with Linux-LTS kernel
# This script follows the guidelines from the Arch Wiki

# Ensure script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root"
    exit 1
fi

# Function to display installation options
display_options() {
    echo "NVIDIA Driver Installation Options:"
    echo "1. Install essential NVIDIA packages"
    echo "2. Install CUDA and related packages"
    echo "3. Install additional NVIDIA packages"
    echo "4. Configure Xorg"
    echo "5. Configure kernel parameters for early KMS"
    echo "6. Reboot system"
    echo "0. Exit"
}

# Install essential NVIDIA packages
install_essential_packages() {
    echo "Installing essential NVIDIA packages..."
    # Note: Avoid installing the NVIDIA driver from the NVIDIA website
    # Installation through pacman allows upgrading the driver with the system
    pacman -S --needed nvidia-lts nvidia-utils lib32-nvidia-utils nvidia-settings
}

# Install CUDA and related packages
install_cuda() {
    echo "Installing CUDA and related packages..."
    pacman -S --needed cuda cuda-tools cudnn python-cuda python-cuda-docs python-pycuda
}

# Install additional NVIDIA packages
install_additional() {
    echo "Installing additional NVIDIA packages..."
    pacman -S --needed bumblebee primus_vk lib32-primus_vk nvidia-prime nvtop \
               libva-nvidia-driver opencl-nvidia lib32-opencl-nvidia \
               egl-wayland ffnvcodec-headers libvdpau lib32-libvdpau
}

# Configure Xorg
configure_xorg() {
    echo "Configuring Xorg..."
    # For basic functionality, kernel parameter should suffice
    # This configuration is for more specific setups
    mkdir -p /etc/X11/xorg.conf.d
    cat > /etc/X11/xorg.conf.d/20-nvidia.conf << EOF
Section "Device"
    Identifier "NVIDIA Card"
    Driver "nvidia"
    Option "NoLogo" "true"
EndSection
EOF
    echo "Xorg configuration complete."
}

# Configure kernel parameters for early KMS
configure_kernel() {
    echo "Configuring kernel parameters for early KMS..."
    # Early loading of NVIDIA modules
    sed -i 's/MODULES=()/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
    mkinitcpio -P
    # Set kernel parameter for DRM KMS
    sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=".*"/GRUB_CMDLINE_LINUX_DEFAULT="quiet nvidia-drm.modeset=1"/' /etc/default/grub
    grub-mkconfig -o /boot/grub/grub.cfg
    echo "Kernel parameters configured."
}

# Reboot system
reboot_system() {
    read -p "Do you want to reboot now? (y/n): " choice
    case "$choice" in 
        y|Y ) reboot;;
        n|N ) echo "Please reboot your system later to apply changes.";;
        * ) echo "Invalid option. Please reboot your system later to apply changes.";;
    esac
}

# Main loop
while true; do
    display_options
    read -p "Enter your choice: " choice
    case $choice in
        1) install_essential_packages ;;
        2) install_cuda ;;
        3) install_additional ;;
        4) configure_xorg ;;
        5) configure_kernel ;;
        6) reboot_system ;;
        0) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid option. Please try again." ;;
    esac
    echo
done
