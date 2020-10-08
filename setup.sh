#!/bin/bash

apt install xorg awesome chromium
apt install laptop-mode-tools fdpowermon

# Grand sudo access
apt install sudo
usermod -aG sudo m.brugidou
apt install krb5-user

# Get all submodules
sudo -u m.brugidou git submodule update --init

# Network
apt install network-manager network-manager-vpnc network-manager-openconnect network-manager-gnome network-manager-openconnect-gnome

# Install vim plugins
apt install vim-nox
sudo -u m.brugidou vim +BundleInstall +q

# Setup urxvt
apt install rxvt-unicode xfonts-terminus
update-alternatives --set x-terminal-emulator /usr/bin/urxvt

# Setup ruby
apt install ruby ruby-dev libyajl-dev build-essential libxml2-dev
gem install bundler

# Nodejs + Npm
apt install npm

# Screensaver
apt install xscreensaver
# Screenshots
apt install flameshot

apt install volumeicon-alsa

# Update daily
apt install unattended-upgrades

# Install snaps
apt install snapd
# Visual Studio Code
snap install code --classic
# IntelliJ
snap install intellij-idea-community --classic

# Dotnet
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg
mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/
wget -q https://packages.microsoft.com/config/debian/9/prod.list
mv prod.list /etc/apt/sources.list.d/microsoft-prod.list
chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg
chown root:root /etc/apt/sources.list.d/microsoft-prod.list
apt update
apt install dotnet-sdk-2.1
apt install dotnet-sdk-3.1

#TODO: download and install zoom

# tooling like add-apt-repository
apt-get install software-properties-common
# Install JDK 8 from Adoptopenjdk and set it by default
wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add -
add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/
apt-get install adoptopenjdk-8-hotspot
update-alternatives --set java /usr/lib/jvm/adoptopenjdk-8-hotspot-amd64/bin/java
