
# Solarized colors
xrdb -merge ~/.Xresources

# Screen layouts
[ -x ~/.screenlayout/criteo.sh ] && ~/.screenlayout/criteo.sh

# Daemon for touchpad (palm check, etc...)
syndaemon -dkt -i 0.5
synclient TapButton1=1
synclient TapButton2=3
synclient TapButton3=2
synclient PalmDetect=1
synclient VertScrollDelta=-36

exec awesome > ~/awesome.log 2>&1
