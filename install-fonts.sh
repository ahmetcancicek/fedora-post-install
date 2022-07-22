#!/bin/bash

# For root control
if [ "$(id -u)" != 0 ]; then
  echo "You are not root! This script must be run as root"
  exit 1
fi

cat <<EOL
========================================================================
Fonts is installing!
========================================================================
EOL

#
dnf install -y powerline-fonts

#
dnf install -y levien-inconsolata-fonts

#
dnf install -y adobe-source-code-pro-fonts

#
dnf install -y mozilla-fira-mono-fonts

#
dnf install -y google-droid-sans-mono-fonts

#
dnf install -y dejavu-sans-mono-fonts

# Hack v3
wget -O hack.zip https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip
unzip hack.zip -d hack-v3
mkdir hack
mv hack-v3/ttf/* hack
mkdir /usr/share/fonts/hack
mv hack /usr/share/fonts/hack
fc-cache -f .
cd -


# Ubuntu Font Family
wget -O ubuntu-font-family.zip https://assets.ubuntu.com/v1/0cef8205-ubuntu-font-family-0.83.zip
unzip ubuntu-font-family.zip
mv ubuntu-font-family-0.83 ubuntu-font-family
mkdir /usr/share/fonts/ubuntu-font-family
mv ubuntu-font-family /usr/share/fonts/ubuntu-font-family
fc-cache -f .
cd -


# JetBrains Mono Font Family
wget https://download.jetbrains.com/fonts/JetBrainsMono-2.242.zip
unzip JetBrainsMono-2.242 -d JetBrainsMono-2.242
mkdir jetbrains-mono
mv JetBrainsMono-2.242/fonts/ttf/** jetbrains-mono
mv jetbrains-mono /usr/share/fonts/jetbrains-mono
fc-cache -f .
cd -

# Install Monaco
mkdir /usr/share/fonts/monaco
cd /usr/share/fonts/monaco
wget http://www.gringod.com/wp-upload/software/Fonts/Monaco_Linux.ttf
fc-cache -f .
cd -


# Install MesloLGS
mkdir /usr/share/fonts/MesloLGS
cd /usr/share/fonts/MesloLGS
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
fc-cache -f .
cd -



cat <<EOL
========================================================================
Congratulations, everything you wanted to install is installed!
========================================================================
EOL

cat <<EOL

EOL