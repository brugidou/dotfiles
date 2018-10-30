. ~/.xsessionrc

# Remove beep
xset -b

systemctl --user start xscreensaver

nm-applet &
fdpowermon &
volumeicon &
# Bluetooth applet
blueman-applet &

exec awesome > ~/awesome.log 2>&1
