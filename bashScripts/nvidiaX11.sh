#!/bin/bash

# NVIDIA Configuration Script for Xorg on Arch Linux

# Ensure script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root"
    exit 1
fi

# Create a directory for Xorg configuration if it doesn't exist
mkdir -p /etc/X11/xorg.conf.d

# Create a basic NVIDIA configuration
cat > /etc/X11/xorg.conf.d/20-nvidia.conf << EOF
Section "Device"
    Identifier "NVIDIA Card"
    Driver "nvidia"
    Option "NoLogo" "true"
EndSection
EOF

# Feedback
echo "NVIDIA configuration for Xorg has been set up successfully."
