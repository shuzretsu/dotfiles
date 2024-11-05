#!/bin/bash

# Check if Rofi is already running
if pgrep -x "rofi" > /dev/null
then
    # If running, close it
    pkill rofi
else
    # Otherwise, launch Rofi
    rofi -show drun -location 1 -yoffset 10 -xoffset 10
fi
