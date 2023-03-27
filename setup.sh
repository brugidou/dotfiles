#!/bin/bash

apt update

# firmwares (SOF firmware for sound card)
apt install fwupd firmware-sof-signed
fwupdmgr update

apt install xorg lightdm awesome chromium arandr autorandr dex light-locker
apt install tlp fdpowermon powertop

# Grand sudo access
apt install sudo
usermod -aG sudo m.brugidou
apt install krb5-user

# Get all submodules
sudo -u m.brugidou git submodule update --init

# Network
apt install network-manager network-manager-vpnc network-manager-openconnect network-manager-gnome network-manager-openconnect-gnome systemd-resolved
# DNS resolver (useful for split DNS for VPN)
systemctl enable systemd-resolved && systemctl start systemd-resolved

# Install vim plugins
apt install vim-nox
sudo -u m.brugidou vim +BundleInstall +q

# Setup urxvt
apt install rxvt-unicode xfonts-terminus
update-alternatives --set x-terminal-emulator /usr/bin/urxvt

# Setup ruby
apt install ruby ruby-dev libyajl-dev build-essential libxml2-dev
gem install bundler

# Screen backlight
apt install xbacklight
# Screenshots
apt install flameshot

# Bluetooth
apt install blueman
apt install pipewire-pulse libspa-0.2-bluetooth wireplumber
# todo: check if need for systemctl --user enable wireplumber
apt install volumeicon-alsa alsa-utils pavucontrol

# Criteo printers
#wget https://criteo.printercloud5.com/client/setup/printerinstallerclient_amd64.deb
#apt install ./printerinstallerclient_amd64.deb

# Update daily
apt install unattended-upgrades

# Install snaps
apt install snapd
# Node + NPM
snap install node --classic
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
apt install dotnet-sdk-5.0

# Zoom
wget https://zoom.us/client/latest/zoom_amd64.deb
apt install ./zoom_amd64.deb
rm -f ./zoom_amd64.deb

wget -O- https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
cat > /etc/apt/sources.list.d/google-chrome.list <<EOF
deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main
EOF
apt update && apt install google-chrome

# Install JDK 8 from Adoptopenjdk and set it by default
wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add -
cat > /etc/apt/sources.list.d/jfrog.list <<EOF
deb [arch=amd64] https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ stretch main
EOF
apt update && apt install adoptopenjdk-8-hotspot
update-alternatives --set java /usr/lib/jvm/adoptopenjdk-8-hotspot-amd64/bin/java

# Install signal app
wget -O- https://updates.signal.org/desktop/apt/keys.asc | apt-key add -
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | tee /etc/apt/sources.list.d/signal-xenial.list
apt update && apt install signal-desktop

# Install docker
apt install docker.io
usermod -aG docker m.brugidou

# Full upgrade and cleanup
apt update
apt dist-upgrade
apt autoremove
