#!/bin/bash

# APT Repositories

# Dotnet
wget -q https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

# Microsoft Edge
wget -qO- https://packages.microsoft.com/keys/microsoft.asc > /etc/apt/trusted.gpg.d/microsoft-edge.asc
cat > /etc/apt/sources.list.d/microsoft-edge.list <<EOF
deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main
EOF

# Google Chrome
wget -qO- https://dl.google.com/linux/linux_signing_key.pub > /etc/apt/trusted.gpg.d/google-chrome.asc
cat > /etc/apt/sources.list.d/google-chrome.list <<EOF
deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main
EOF


# Remove JDK 8 from Adoptopenjdk
rm -f /etc/apt/trusted.gpg.d/adoptopenjdk.asc
rm -f /etc/apt/sources.list.d/jfrog.list

# Signal app
wget -qO- https://updates.signal.org/desktop/apt/keys.asc > /etc/apt/trusted.gpg.d/signal.asc
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | tee /etc/apt/sources.list.d/signal-xenial.list

apt update

installPkgs=(
  # firmwares (SOF firmware for sound card)
  fwupd firmware-sof-signed
  firmware-realtek

  xorg lightdm awesome chromium arandr autorandr dex light-locker
  # Needed for zoom screensharing
  # https://support.zoom.com/hc/en/article?id=zm_kb&sysparm_article=KB0060527
  xcompmgr
  tlp fdpowermon powertop

  sudo krb5-user

  # Network
  network-manager network-manager-vpnc network-manager-openconnect network-manager-gnome network-manager-openconnect-gnome systemd-resolved

  vim-nox
  rxvt-unicode xfonts-terminus
  ruby ruby-dev libyajl-dev build-essential libxml2-dev

  # Screen backlight
  xbacklight
  # Screenshots
  flameshot

  # Bluetooth
  blueman
  pipewire-pulse libspa-0.2-bluetooth wireplumber
  # todo: check if need for systemctl --user enable wireplumber
  volumeicon-alsa alsa-utils pavucontrol

  cups

  # Update daily
  unattended-upgrades

  # Install snaps
  snapd

  dotnet-sdk-8.0

  google-chrome-stable

  default-jdk

  signal-desktop

  docker.io
)
# remove jdk 8
apt remove adoptopenjdk-8-hotspot

apt install ${installPkgs[@]}

# Grand sudo access
usermod -aG sudo m.brugidou

# update firmwares
fwupdmgr update

# Get all submodules
sudo -u m.brugidou git submodule update --init

# DNS resolver (useful for split DNS for VPN)
systemctl enable systemd-resolved && systemctl start systemd-resolved

# Install vim plugins
sudo -u m.brugidou vim +BundleInstall +q

# Setup urxvt
update-alternatives --set x-terminal-emulator /usr/bin/urxvt

# Setup ruby
gem install bundler

# Criteo printers
if ! lpstat -p | grep -q Criteo4th ; then
  echo Adding printer for Criteo 4th floor...
  lpadmin -p Criteo4th -m lsb/usr/cupsfilters/Generic-PDF_Printer-PDF.ppd -v socket://172.29.8.38:9100  -L 172.29.8.38
fi

# Node + NPM
snap install node --classic
# Visual Studio Code
snap install code --classic
# IntelliJ
snap install intellij-idea-community --classic

# Zoom
wget https://zoom.us/client/latest/zoom_amd64.deb
apt install ./zoom_amd64.deb
rm -f ./zoom_amd64.deb

# Install docker
usermod -aG docker m.brugidou

# Full upgrade and cleanup
apt dist-upgrade
apt autoremove
