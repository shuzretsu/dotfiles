#!/bin/bash

# Close any existing `rofi` menu
if pgrep -x "rofi" > /dev/null; then
    pkill rofi
    exit
fi

# Show the power menu
chosen=$(echo -e "Logout\nSleep\nReboot\nPoweroff" | rofi -dmenu -p "Power Menu" \
    -location 3 -yoffset 32 -xoffset -5 -width 15 -lines 4 -hide-scrollbar \
    -theme-str 'window {width: 15%; height: 25%;} listview {padding: 5px;}')

case "$chosen" in
    Logout) loginctl terminate-session "$XDG_SESSION_ID" ;;
    Sleep) systemctl suspend ;;
    Reboot) systemctl reboot ;;
    Poweroff) systemctl poweroff ;;
esac

