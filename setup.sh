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
