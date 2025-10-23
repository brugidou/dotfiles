#!/bin/bash

# APT Repositories

# Dotnet and Microsoft Defender
wget -q https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

# Microsoft Edge
wget -qO- https://packages.microsoft.com/keys/microsoft.asc > /etc/apt/trusted.gpg.d/microsoft-edge.asc
cat > /etc/apt/sources.list.d/microsoft-edge.list <<EOF
deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main
EOF
# VS Code
cat > /etc/apt/sources.list.d/vscode.list <<EOF
deb [arch=amd64,arm64,armhf] https://packages.microsoft.com/repos/code stable main
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

  # Microsoft Defender
  mdatp

  # VS Code
  code
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
sudo -u m.brugidou vim +BundleInstall +q +q

# Setup urxvt
update-alternatives --set x-terminal-emulator /usr/bin/urxvt
# Set vim as default editor
update-alternatives --set editor /usr/bin/vim.nox

# Setup ruby
gem install bundler

# Criteo printers
if ! lpstat -p | grep -q Criteo4th ; then
  echo Adding printer for Criteo 4th floor...
  lpadmin -p Criteo4th -m lsb/usr/cupsfilters/Generic-PDF_Printer-PDF.ppd -v socket://172.29.8.38:9100  -L 172.29.8.38
fi

# Node + NPM
snap install node --classic
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

#
# TODO: set up intune for Debian, for now this is done manually
#
cat > /etc/apt/sources.list.d/microsoft-intune.list <<EOF
# for intune-portal
#deb [arch=amd64] https://packages.microsoft.com/ubuntu/22.04/prod jammy main
# for old jq and other libs
#deb [arch=amd64] http://deb.debian.org/debian/ stable main
# for openjdk-11-jre
#deb [arch=amd64] http://deb.debian.org/debian/ oldstable main
EOF

# Enable oldstable
# apt install openjdk-11-jre
# update-alternatives --set java /usr/lib/jvm/java-11-openjdk-amd64

# Enable stable
# apt install jq=1.6-2.1 libjq=1.6-2.1 --allow-downgrades
# apt-mark hold jq
# apt install libicu72 libjavascriptcoregtk-4.0-18 libwebkit2gtk-4.0-37

# Enable microsoft ubuntu repo
# apt install microsoft-identity-broker=1.7.0
# apt-mark hold microsoft-identity-broker
# apt install intune-portal

# Don't forget to remove lsb_release and set /etc/os-release to
wget -O /etc/os-release https://raw.githubusercontent.com/chef/os_release/refs/heads/main/ubuntu_2204
# Fix uname -a kernel patch level
if ! grep 0-19 /usr/bin/uname; then
  cp /usr/bin/uname{,.backup}
  cat > /usr/bin/uname <<'EOF'
#!/bin/bash
if [ "$1" == "-r" ] ; then
  echo "6.5.0-19"
else
  /usr/bin/uname.backup $@
fi
EOF
  chmod +x /usr/bin/uname
fi

# And tweak gsettings to have:
# org.gnome.desktop.screensaver lock-enabled true
# org.gnome.desktop.screensaver idle-activation-enabled true
# org.gnome.desktop.screensaver lock-delay uint32 0
# org.gnome.desktop.session idle-delay uint32 300


# Defender onboarding
if ! mdatp health --field healthy  | grep -q true; then
  wget -O /tmp/MicrosoftDefenderATPOnboardingLinuxServer.py https://repo.criteois.com/master/MicrosoftDefenderATPOnboardingLinuxServer.py
  python3 /tmp/MicrosoftDefenderATPOnboardingLinuxServer.py
fi
# check status with mdatp health
