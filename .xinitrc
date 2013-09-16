
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
synclient HorizScrollDelta=-36
synclient HorizTwoFingerScroll=1
synclient MaxSpeed=10
synclinet SingleTapTimeout=50
synclient FingerLow=10
synclient FingerHigh=18

exec awesome > ~/awesome.log 2>&1
