. ~/.xsessionrc

# Remove beep
xset -b

systemctl --user start xscreensaver

# NetworkManager applet
nm-applet &
# Power Monitor
fdpowermon &
# Bluetooth applet
blueman-applet &
# xSwipe for touchpad on XPS
cd ~/git/xSwipe && perl xSwipe.pl -n -d 0.2 >> ~/xSwipe.log 2>&1 &

exec awesome > ~/awesome.log 2>&1
