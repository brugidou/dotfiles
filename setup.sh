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
apt install network-manager network-manager-vpnc network-manager-openconnect network-manager-gnome

# Install vim plugins
apt install vim-nox
sudo -u m.brugidou vim +BundleInstall +q

# Setup urxvt
apt install rxvt-unicode xfonts-terminus
update-alternatives --set x-terminal-emulator /usr/bin/urxvt

# Setup ruby
apt install ruby ruby-dev libyajl-dev build-essential libxml2-dev
gem install bundler

# Screensaver
apt install xscreensaver

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
apt install dotnet-sdk-2.1=2.1.504-1
