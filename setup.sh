#!/bin/bash

# APT Repositories

# Dotnet
wget -q https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

# Google Chrome
wget -qO- https://dl.google.com/linux/linux_signing_key.pub > /etc/apt/trusted.gpg.d/google-chrome.asc
cat > /etc/apt/sources.list.d/google-chrome.list <<EOF
deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main
EOF


# Install JDK 8 from Adoptopenjdk and set it by default
wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public > /etc/apt/trusted.gpg.d/adoptopenjdk.asc
cat > /etc/apt/sources.list.d/jfrog.list <<EOF
deb [arch=amd64] https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ stretch main
EOF

# Signal app
wget -qO- https://updates.signal.org/desktop/apt/keys.asc > /etc/apt/trusted.gpg.d/signal.asc
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | tee /etc/apt/sources.list.d/signal-xenial.list

apt update

installPkgs=(
  # firmwares (SOF firmware for sound card)
  fwupd firmware-sof-signed
  firmware-realtek

  xorg lightdm awesome chromium arandr autorandr dex light-locker
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

  adoptopenjdk-8-hotspot

  signal-desktop

  docker.io
)

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

# Set java 8 as default
update-alternatives --set java /usr/lib/jvm/adoptopenjdk-8-hotspot-amd64/bin/java

# Install docker
usermod -aG docker m.brugidou

# Full upgrade and cleanup
apt dist-upgrade
apt autoremove
