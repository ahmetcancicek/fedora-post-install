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

writeInstallationMessage() {
  printf "\n${BLUE}===============================Installing $1==============================${ENDCOLOR}\n"
}

writeInstallationSuccessfulMessage() {
  printf "${GREEN}========================$1 is installed successfully!========================${ENDCOLOR}\n"
}

# Set Version
JETBRAINS_VERSION=2022.1.3
GO_VERSION=1.18.3
POSTMAN_VERSION=9.20.3
MAVEN=3
MAVEN_VERSION=3.8.6
GRADLE_VERSION=7.5
DROIDCAM_VERSION=1.8.1
DROPBOX_VERSION=2020.03.04

# Get USER name
USER=$(logname)

# Get HOME folder path
HOME=/home/$USER

# Go TEMP folder
cd /tmp

# Update
printf "\n${BLUE}========================Installing Updating========================${ENDCOLOR}\n"
dnf -y update
printf "${GREEN}========================Updated successfully!========================${ENDCOLOR}\n"

# Upgrade
printf "\n${BLUE}========================Upgrading========================${ENDCOLOR}\n"
dnf -y upgrade
printf "${GREEN}========================Upgared successfully!========================${ENDCOLOR}\n"

# Install standard package
printf "\n${BLUE}========================Installing standard package $1========================${ENDCOLOR}\n"
dnf install -y \
  ca-certificates \
  curl \
  wget \
  dialog \
  tree \
  zsh \
  dialog \
  gnome-font-viewer \
  htop
printf "\n${BLUE}===============Standard packages are installed successfully===============${ENDCOLOR}\n"

cmd=(dialog --title "Fedora 35 Installer" --separate-output --checklist 'Please choose: ' 27 76 16)
options=(
  A1 "Install Snap Repository" off
  A2 "Install Flatpak Repository" off
  # B: Internet
  B1 "Google Chrome" off
  B2 "Chromium" off
  B3 "Spotify (Snap)" off
  B4 "Opera" off
  B5 "Microsoft Edge" off
  # C: Chat Application
  C1 "Zoom Meeting Client" off
  C2 "Discord (Snap)" off
  C3 "Thunderbird Mail" off
  C4 "Skype (Snap)" off
  C5 "Slack (Snap)" off
  C6 "Microsoft Teams (Snap)" off
  # D: Development
  D1 "GIT" off
  D2 "JAVA" off
  D3 "GO" off
  D4 "Microsoft Visual Studio Code" off
  D5 "IntelliJ IDEA Ultimate" off
  D6 "GoLand" off
  D7 "Postman" off
  D8 "Docker" off
  D9 "Maven" off
  D10 "Gradle" off
  D11 "Putty" off
  D12 "Vim" off
  D13 "DataGrid" off
  D14 "Mongo Shell & MongoDB Database Tools" off
  # E: Gnome Tweaks
  E1 "Gnome Tweak Tool" off
  E2 "Gnome Shell Extensions" off
  # F: Utility
  F1 "Dropbox" off
  F2 "KeePassXC" off
  F3 "Terminator" off
  F4 "Gnome Boxes" off
  # G: Image, Video and Audio
  G1 "GIMP" off
  G2 "Droidcam" off
)

choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices; do
  case $choice in
  A1)
    writeInstallationMessage Snap-Repository
    dnf -y install snapd
    snap install snap-store
    writeInstallationSuccessfulMessage Snap-Repository
    ;;
  A2)
    writeInstallationMessage Flatpak-Repository
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    writeInstallationSuccessfulMessage Flatpak-Repository
    ;;

  B1)
    writeInstallationMessage Google-Chrome
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
    dnf install -y ./google-chrome-stable_current_x86_64.rpm
    writeInstallationSuccessfulMessage Google-Chrome
    ;;
  B2)
    writeInstallationMessage Chromium
    dnf -y install chromium
    writeInstallationSuccessfulMessage Chromium
    ;;
  B3)
    writeInstallationMessage Spotify
    snap install spotify
    writeInstallationSuccessfulMessage Spotify
    ;;
  B4)
    writeInstallationMessage Opera
    dnf config-manager --add-repo https://rpm.opera.com/rpm
    rpm --import https://rpm.opera.com/rpmrepo.key
    dnf upgrade --refresh
    dnf install -y opera-stable
    writeInstallationSuccessfulMessage Opera
    ;;
  B5)
    writeInstallationMessage Microsoft-Edge
    rpm --import https://packages.microsoft.com/keys/microsoft.asc
    dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge
    dnf update --refresh
    dnf install microsoft-edge-stable
    writeInstallationSuccessfulMessage Microsoft-Edge
    ;;

  C1)
    writeInstallationMessage Zoom
    wget https://zoom.us/client/latest/zoom_x86_64.rpm
    dnf -y install ./zoom_x86_64.rpm
    writeInstallationSuccessfulMessage Zoom
    ;;
  C2)
    writeInstallationMessage Discord
    snap install discord
    writeInstallationSuccessfulMessage Discord
    ;;
  C3)
    writeInstallationMessage Thunderbird
    dnf -y install thunderbird
    writeInstallationSuccessfulMessage Thunderbird
    ;;
  C4)
    writeInstallationMessage Skype
    snap install skype
    writeInstallationSuccessfulMessage Skype
    ;;
  C5)
    writeInstallationMessage Slack
    snap install slack --classic
    writeInstallationSuccessfulMessage Slack
    ;;
  C6)
    writeInstallationMessage Teams
    snap install teams
    writeInstallationSuccessfulMessage Teams
    ;;

  D1)
    writeInstallationMessage GIT
    dnf -y install git
    writeInstallationSuccessfulMessage GIT
    ;;
  D2)
    writeInstallationMessage JAVA-JDK-18
    wget https://download.oracle.com/java/18/latest/jdk-18_linux-x64_bin.tar.gz
    tar xf jdk-18_linux-x64_bin.tar.gz -C /usr/local/java/
    update-alternatives --install "/usr/bin/java" "java" "/usr/local/java/jdk-18.0.1.1/bin/java" 1
    update-alternatives --install "/usr/bin/javac" "javac" "/usr/local/java/jdk-18.0.1.1/bin/javac" 1
    update-alternatives --set java /usr/local/java/jdk-18.0.1.1/bin/java
    update-alternatives --set javac /usr/local/java/jdk-18.0.1.1/bin/javac
    echo -e ' \n"# Java Configuration\nexport JAVA_HOME=/opt/jdk-18.0.1.1\nexport PATH=$PATH:$HOME/bin:$JAVA_HOME/bin' >> /etc/profile.d/javaenv.sh
    source /etc/profile.d/javaenv.sh
    writeInstallationSuccessfulMessage JAVA-JDK-18

    writeInstallationMessage JAVA-JDK-17
    wget https://download.oracle.com/java/17/archive/jdk-17_linux-x64_bin.tar.gz
    tar xf jdk-17_linux-x64_bin.tar.gz -C /usr/local/java
    update-alternatives --install "/usr/bin/java" "java" "/usr/local/java/jdk-17/bin/java" 2
    update-alternatives --install "/usr/bin/javac" "javac" "/usr/local/java/jdk-17/bin/javac" 2
    writeInstallationSuccessfulMessage JAVA-JDK-17

    writeInstallationMessage Spring-Boot-CLI
    wget https://repo.spring.io/release/org/springframework/boot/spring-boot-cli/2.7.1/spring-boot-cli-2.7.1-bin.tar.gz
    tar xf spring-boot-cli-2.7.1-bin.tar.gz -C /opt
    echo -e ' \n# Spring Boot CLI\nexport SPRING_HOME=/opt/spring-2.7.1/\nexport PATH=$PATH:$HOME/bin:$SPRING_HOME/bin' >>/etc/profile.d/springenv.sh
    source /etc/profile.d/springenv.sh
    writeInstallationSuccessfulMessage Spring-Boot-CLI
    ;;
  D3)
    writeInstallationMessage Go
    wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz
    rm -rf /usr/local/go && tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
    echo -e ' \n# GoLang configuration\nexport PATH="$PATH:/usr/local/go/bin"\nexport GOPATH="$HOME/go"' >>/etc/profile.d/goenv.sh
    source /etc/profile.d/goenv.sh
    writeInstallationSuccessfulMessage Go
    ;;
  D4)
    writeInstallationMessage vscode
    rpm --import https://packages.microsoft.com/keys/microsoft.asc
    dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge
    dnf check-update
    dnf -y install code
    writeInstallationSuccessfulMessage vscode
    ;;
  D5)
    writeInstallationMessage IntelliJ-IDEA
    wget https://download.jetbrains.com/idea/ideaIU-${JETBRAINS_VERSION}.tar.gz -O ideaIU.tar.gz
    tar -xzf ideaIU.tar.gz -C /opt
    mv /opt/idea-IU-* /opt/idea-IU-${JETBRAINS_VERSION}
    ln -s /opt/idea-IU-${JETBRAINS_VERSION}/bin/idea.sh /usr/local/bin/idea
    echo "[Desktop Entry]
    Version=1.0
    Type=Application
    Name=IntelliJ IDEA Ultimate Edition
    Icon=/opt/idea-IU-${JETBRAINS_VERSION}/bin/idea.svg
    Exec=/opt/idea-IU-${JETBRAINS_VERSION}/bin/idea.sh %f
    Comment=Capable and Ergonomic IDE for JVM
    Categories=Development;IDE;
    Terminal=false
    StartupWMClass=jetbrains-idea
    StartupNotify=true;" >>/usr/share/applications/jetbrains-idea.desktop
    writeInstallationSuccessfulMessage IntelliJ-IDEA
    ;;
  D6)
    writeInstallationMessage GoLand
    wget https://download.jetbrains.com/go/goland-${JETBRAINS_VERSION}.tar.gz -O goland.tar.gz
    tar -xzf goland.tar.gz -C /opt
    ln -s /opt/GoLand-${JETBRAINS_VERSION}/bin/goland.sh /usr/local/bin/goland
    echo -e "[Desktop Entry]
    Version=1.0
    Type=Application
    Name=GoLand
    Icon=/opt/GoLand-${JETBRAINS_VERSION}/bin/goland.png
    Exec=/opt/GoLand-${JETBRAINS_VERSION}/bin/goland.sh
    Terminal=false\nCategories=Development;IDE;" >>/usr/share/applications/jetbrains-goland.desktop
    writeInstallationSuccessfulMessage GoLand
    ;;
  D7)
    writeInstallationMessage Postman
    curl https://dl.pstmn.io/download/latest/linux64 --output postman-${POSTMAN_VERSION}-linux-x64.tar.gz
    tar -xzf postman-${POSTMAN_VERSION}-linux-x64.tar.gz -C /opt
    echo "[Desktop Entry]
          Encoding=UTF-8
          Name=Postman
          Exec=/opt/Postman/app/Postman %U
          Icon=/opt/Postman/app/resources/app/assets/icon.png
          Terminal=false
          Type=Application
          Categories=Development;" >>/usr/share/applications/Postman.desktop
    writeInstallationSuccessfulMessage Postman
    ;;
  D8)
    writeInstallationMessage Docker
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

    dnf -y install docker-ce docker-ce-cli containerd.io
    systemctl start docker
    docker run hello-world
    groupadd docker
    usermod -a -G docker $USER
    writeInstallationSuccessfulMessage Docker

    writeInstallationMessage docker-compose
    curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    docker-compose --version
    writeInstallationSuccessfulMessage docker-compose
    ;;
  D9)
    writeInstallationMessage Maven
    wget https://dlcdn.apache.org/maven/maven-${MAVEN}/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz
    tar -zxvf apache-maven-${MAVEN_VERSION}-bin.tar.gz -C /opt
    ln -s /opt/apache-maven-${MAVEN_VERSION} /opt/maven
    echo ' ' >>/etc/profile.d/maven.sh
    echo '# Maven Configuration' >>/etc/profile.d/maven.sh
    echo 'JAVA_HOME=/usr/lib/jvm/default-java' >>/etc/profile.d/maven.sh
    echo 'export M2_HOME=/opt/maven' >>/etc/profile.d/maven.sh
    echo 'export PATH=${M2_HOME}/bin:${PATH}' >>/etc/profile.d/maven.sh
    source /etc/profile.d/maven.sh
    writeInstallationSuccessfulMessage Maven
    ;;
  D10)
    writeInstallationMessage Gradle
    wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
    mkdir /opt/gradle
    unzip -d /opt/gradle gradle-${MAVEN_VERSION}-bin.zip
    echo ' ' >>/etc/profile.d/gradle.sh
    echo 'export PATH=$PATH:/opt/gradle/gradle-${GRADLE_VERSION}/bin' >>/etc/profile.d/gradle.sh
    writeInstallationSuccessfulMessage Gradle
    ;;
  D11)
    writeInstallationMessage PuTTY
    dnf -y install putty
    writeInstallationSuccessfulMessage PuTTY
    ;;
  D12)
    writeInstallationMessage Vim
    dnf -y install vim
    writeInstallationSuccessfulMessage Vim
    ;;
  D13)
    writeInstallationMessage DataGrip
    wget https://download.jetbrains.com/datagrip/datagrip-${JETBRAINS_VERSION}.tar.gz
    tar -xzf datagrip-${JETBRAINS_VERSION}.tar.gz -C /opt
    ln -s /opt/DataGrip-${JETBRAINS_VERSION}/bin/datagrip.sh /usr/local/bin/datagrip
    echo "[Desktop Entry]
          Version=1.0
          Type=Application
          Name=DataGrip
          Icon=/opt/DataGrip-${JETBRAINS_VERSION}/bin/datagrip.png
          Exec=/opt/DataGrip-${JETBRAINS_VERSION}/bin/datagrip.sh
          Terminal=false
          Categories=Development;IDE;" >>/usr/share/applications/jetbrains-datagrip.desktop
    writeInstallationSuccessfulMessage DataGrip
    ;;
  D14)
    writeInstallationMessage Mongo-Shell
    wget -O mongosh.rpm https://downloads.mongodb.com/compass/mongodb-mongosh-1.2.2.el8.x86_64.rpm
    dpkg -i ./mongosh.rpm
    writeInstallationSuccessfulMessage Mongo-Shell

    writeInstallationMessage MongoDB-Database-Tools
    wget -O mongodb-database-tools.rpm https://fastdl.mongodb.org/tools/db/mongodb-database-tools-rhel80-x86_64-100.5.2.rpm
    dpkg -i ./mongodb-database-tools.rpm
    writeInstallationSuccessfulMessage MongoDB-Database-Tools
    ;;

  E1)
    writeInstallationMessage Gnome-Twek-Tool
    dnf install -y gnome-tweak-tool
    writeInstallationSuccessfulMessage Gnome-Twek-Tool
    ;;
  E2)
    writeInstallationMessage Gnome-Extensions
    dnf install -y gnome-extensions-app
    dnf install -y gnome-shell-extension-appindicator
    writeInstallationSuccessfulMessage Gnome-Extensions
    ;;

  F1)
    writeInstallationMessage Dropbox
    wget -O dropbox.rpm https://www.dropbox.com/download?dl=packages/fedora/nautilus-dropbox-2020.03.04-1.fedora.x86_64.rpm
    dnf install -y ./dropbox.rpm
    writeInstallationSuccessfulMessage Dropbox
    echo -e "[Dropbox]\nname=Dropbox Repository\baseurl=http://linux.dropbox.com/fedora/35/\n    gpgkey=https://linux.dropbox.com/fedora/rpm-public-key.asc" >/etc/yum.repos.d/dropbox.repo
    ;;
  F2)
    writeInstallationMessage KeePassXC
    dnf install -y keepassxc
    writeInstallationSuccessfulMessage KeePassXC
    ;;
  F3)
    writeInstallationMessage Terminator
    dnf -y install terminator
    writeInstallationSuccessfulMessage Terminator
    ;;
  F4)
    writeInstallationMessage Boxes
    dnf install gnome-boxes
    writeInstallationSuccessfulMessage Boxes
    ;;

  G1)
    dnf -y install gimp
    ;;
  G2)
    wget -O droidcam_latest.zip https://files.dev47apps.net/linux/droidcam_1.8.1.zip
    unzip droidcam_latest.zip -d droidcam
    cd droidcam && ./install-client
    dnf -y install linux-headers-$(uname -r) gcc make
    ./install-video
    dnf -y install libappindicator-gtk3
    ;;

  *) ;;
  esac
done

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
