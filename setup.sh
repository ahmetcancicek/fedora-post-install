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
  A1 "Install Snap Repository" on
  A2 "Install Flatpak Repository" on
  # B: Internet
  B1 "Google Chrome" off
  B2 "Chromium" off
  B3 "Spotify (Snap)" off
  B4 "Opera" off
  # C: Chat Application
  C1 "Zoom Meeting Client" off
  C2 "Discord" off
  C3 "Thunderbird Mail" off
  C4 "Skype (Snap)" off
  C5 "Slack" off
  C6 "Microsoft Teams (Snap)" off
  # D: Development
  D1 "GIT" off
  D2 "JAVA" off
  D3 "GO" off
  D4 "Microsoft Visual Studio Code" off
  D5 "IntelliJ IDEA Ultimate (Snap)" off
  D6 "GoLand (Snap)" off
  D7 "Postman (Snap)" off
  D8 "Docker" off
  D9 "Maven" off
  D10 "Putty" off
  D11 "Vim" off
  D12 "PyCharm" off
  D13 "Robo 3T" off
  D14 "DataGrid" off
  D15 "Mongo Shell & MongoDB Database Tools" off
  # E: Gnome Tweaks
  E1 "Gnome Tweak Tool" off
  E2 "Gnome Shell Extensions" off
  # F: Utility
  F1 "Dropbox" off
  F2 "KeePassXC" off
  F3 "Virtualbox" off
  F4 "Terminator" off
  F5 "Powerline" off
  F6 "Htop" off
  F7 "vimrc" off
  # G: Image, Video and Audio
  G1 "GIMP" off
  G2 "Droidcam" off
)

choices=$("${cmd[@]}" "${options[@]}" 2>&1 > /dev/tty)
clear
for choice in $choices; do
  case $choice in
  A1)
    dnf -y install snapd
    snap install snap-store
    ;;
  A2)
    flatpak remote-add --if-not-exists fedora oci+https://registry.fedoraproject.org
    flatpak remote-ls flathub --app
    ;;

  B1)
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
    dnf -y install ./google-chrome-stable_current_x86_64.rpm
    ;;
  B2)
    dnf -y install chromium
    ;;
  B3)
    snap install spotify
    ;;
  B4)
    snap install opera
    ;;

  C1)
    wget https://zoom.us/client/latest/zoom_x86_64.rpm
    dnf -y install ./zoom_x86_64.deb
    ;;
  C2)
    snap install discord
    ;;
  C3)
     dnf -y install thunderbird
     ;;
  C4)
    snap install skype
    ;;
  C5)
    snap install slack --classic
    ;;
  C6)
    snap install teams
    ;;

  D1)
    dnf -y install git
    ;;
  D2)
    dnf -y install default-jdk
    ;;
  D3)
    wget https://golang.org/dl/go1.17.1.linux-amd64.tar.gz
    rm -rf /usr/local/go && tar -C /usr/local -xzf go1.17.1.linux-amd64.tar.gz
    echo ' ' >> $HOME/.bashrc
    echo '# GoLang configuration ' >> $HOME/.bashrc
    echo 'export PATH="$PATH:/usr/local/go/bin"' >> $HOME/.bashrc
    echo 'export GOPATH="$HOME/go"' >> $HOME/.bashrc
    source $HOME/.bashrc
    ;;
  D4)
    rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'    rm -f packages.microsoft.gpg
    dnf check-update
    dnf install code
    ;;
  D5)
    snap install intellij-idea-ultimate --classic
    ;;
  D6)
    sudo snap install goland --classic
    ;;
  D7)
    snap install postman
    ;;
  D8)
    dnf remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine

    dnf -y install dnf-plugins-core
    dnf config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo

    dnf install docker-ce docker-ce-cli containerd.io
    systemctl start docker
    docker run hello-world

    curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    docker-compose --version
    ;;
  D9)
    wget https://dlcdn.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
    tar -zxvf apache-maven-3.6.3-bin.tar.gz
    mkdir /opt/maven
    mv ./apache-maven-3.6.3 /opt/maven/
    echo ' ' >> $HOME/.bashrc
    echo '# Maven Configuration' >> $HOME/.bashrc
    echo 'JAVA_HOME=/usr/lib/jvm/default-java' >> $HOME/.bashrc
    echo 'export M2_HOME=/opt/maven/apache-maven-3.6.3' >> $HOME/.bashrc
    echo 'export PATH=${M2_HOME}/bin:${PATH}' >> $HOME/.bashrc
    source $HOME/.bashrc
    ;;
  D10)
    dnf -y install putty
    ;;
  D11)
    dnf -y install vim
    ;;
  D12)
    snap install pycharm-community --classic
    ;;
  D13)
    snap install robo3t-snap
    ;;
  D14)
    snap install datagrip --classic
    ;;
  D15)
    wget -O mongosh.rpm https://downloads.mongodb.com/compass/mongodb-mongosh-1.2.2.el8.x86_64.rpm
    dpkg -i ./mongosh.rpm

    wget -O mongodb-database-tools.rpm https://fastdl.mongodb.org/tools/db/mongodb-database-tools-rhel80-x86_64-100.5.2.rpm
    dpkg -i ./mongodb-database-tools.rpm
    ;;

  E1)
    dnf -y install gnome-tweak-tool
    ;;
  E2)
    dnf -y install gnome-shell-extensions
    ;;

  F1)
    wget -O dropbox.rpm https://www.dropbox.com/download?dl=packages/fedora/nautilus-dropbox-2020.03.04-1.fedora.x86_64.rpm
    dnf -y install ./dropbox.rpm
    ;;
  F2)
    snap install keepassxc
    ;;
  F3)
    # TODO: Write command to install the VirtualBox
    ;;
  F4)
    dnf -y install terminator
    ;;
  F5)
    dnf -y instal powerline fonts-powerline
    # TODO: Fix configuration
    ;;
  F6)
    dnf -y install htop
    ;;
  F7)
    git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
    sh ~/.vim_runtime/install_awesome_vimrc.sh
    ;;

  G1)
    dnf -y install gimp
    ;;
  G2)
    cd /tmp/
    wget -O droidcam_latest.zip https://files.dev47apps.net/linux/droidcam_1.8.1.zip
    unzip droidcam_latest.zip -d droidcam
    cd droidcam && ./install-client
    dnf -y install linux-headers-`uname -r` gcc make
    ./install-video

    dnf -y install libappindicator-gtk3
    ;;
  *)
  esac
done


cat <<EOL
---------------------------------------------------------------
Congratulations, everything you wanted to install is installed!
---------------------------------------------------------------
EOL

cat <<EOL

EOL

read -p "Are you going to reboot this machine for stability? (y/n): " -n 1 answer
if [[ $answer =~ ^[Yy]$ ]];then
  reboot
fi


cat <<EOL

EOL
