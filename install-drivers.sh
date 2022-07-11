#!/bin/bash

# For root control
if [ "$(id -u)" != 0 ]; then
  echo "You are not root! This script must be run as root"
  exit 1
fi

cat <<EOL
---------------------------------------------------------------
NVIDIA is installing!
---------------------------------------------------------------
EOL


dnf config-manager --set-enabled rpmfusion-nonfree-nvidia-driver
dnf -y install akmod-nvidia xorg-x11-drv-nvidia-cuda

cat <<EOL
---------------------------------------------------------------
Congratulations, everything you wanted to install is installed!
---------------------------------------------------------------
EOL

cat <<EOL

EOL

read -p "Are you going to reboot this machine for stability? (y/n): " -n 1 answer
if [[ $answer =~ ^[Yy]$ ]]; then
  reboot
fi

cat <<EOL

EOL