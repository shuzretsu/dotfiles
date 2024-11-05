#!/bin/bash
chosen=$(echo -e "Lock\nSleep\nReboot\nPoweroff" | rofi -dmenu -p "Power Menu" -location 1 -yoffset 10 -xoffset 10)
case "$chosen" in
    Lock) ly.system --command "lock" ;;
    Sleep) systemctl suspend ;;
    Reboot) systemctl reboot ;;
    Poweroff) systemctl poweroff ;;
esac