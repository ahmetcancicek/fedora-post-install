#!/bin/bash

# For root control
if [ "$(id -u)" != 0 ]; then
  echo "You are not root! This script must be run as root"
  exit 1
fi

# Get USER name
USER=$(logname)

# Get HOME folder path
HOME=/home/$USER

# Go TEMP folder
cd /tmp

# Update
dnf -y update

# Upgrade
dnf -y upgrade

# Install standard package
dnf install -y \
  ca-certificates \
  curl \
  gnupg \
  lsb-release \
  wget \
  dialog

cmd=(dialog --title "Fedora 35 Installer" --separate-output --checklist 'Please choose: ' 27 76 16)
options=(
  # A: Software Repositories
  A1 "Install Snap Repository" on
)

choices=$("${cmd[@]}" "${options[@]}" 2>&1 > /dev/tty)
clear
for choice in $choices; do
  case $choice in
  A1)
    dnf -y install snapd
    snap install snap-store
    ;;
  *)
  esac
done
