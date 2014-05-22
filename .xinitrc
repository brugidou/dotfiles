. ~/.xsessionrc

# Remove beep
xset -b

xscreensaver -no-splash &

# NetworkManager applet
nm-applet &
# Power Monitor
fdpowermon &
# Bluetooth applet
blueman-applet &
# xSwipe for touchpad on XPS
cd ~/git/xSwipe && perl xSwipe.pl -n -d 0.2 >> ~/xSwipe.log 2>&1 &
# Synergy
synergys --restart --config ~/.config/synergy/synergy.conf --log ~/synergys.log

exec awesome > ~/awesome.log 2>&1
