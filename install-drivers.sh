#!/bin/bash

# Set Color
RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
ENDCOLOR="\e[0m"

# For root control
if [ "$(id -u)" != 0 ]; then
  printf "${RED}"
  cat <<EOL
========================================================================
You are not root! This script must be run as root!
========================================================================
EOL
  printf "${ENDCOLOR}"
  exit 1
fi

printf "${BLUE}"
cat <<EOL
========================================================================
NVIDIA is installing!
========================================================================
EOL
printf "${ENDCOLOR}"

#
dnf config-manager --set-enabled rpmfusion-nonfree-nvidia-driver

#
dnf -y install akmod-nvidia xorg-x11-drv-nvidia-cuda

printf "${GREEN}"
cat <<EOL
========================================================================
Congratulations, everything you wanted to install is installed!
========================================================================
EOL
printf "${ENDCOLOR}"

cat <<EOL

EOL

printf "${BLUE}"
read -p "Are you going to reboot this machine for stability? (y/n): " -n 1 answer
printf "${ENDCOLOR}"
if [[ $answer =~ ^[Yy]$ ]]; then
  reboot
fi

cat <<EOL

EOL