#!/bin/bash

# For root control
if [ "$(id -u)" != 0 ]; then
  echo "You are not root! This script must be run as root"
  exit 1
fi

cat <<EOL
---------------------------------------------------------------
Fonts is installing!
---------------------------------------------------------------
EOL

dnf install -y powerline-fonts

# Install Monaco
mkdir /usr/share/fonts/Monaco
cd /usr/share/fonts/Monaco
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
---------------------------------------------------------------
Congratulations, everything you wanted to install is installed!
---------------------------------------------------------------
EOL

cat <<EOL

EOL