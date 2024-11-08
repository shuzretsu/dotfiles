#!/bin/bash

# Check if Rofi is already running
if pgrep -x "rofi" > /dev/null
then
    # If running, close it
    pkill rofi
else
    # Otherwise, launch Rofi with custom size and position
    rofi -show drun \
         -location 1 \
         -yoffset 299\
         -xoffset 5 \
         -width 50 \
         -lines 15 \
         -theme-str 'window {width: 15%; height: 50%; anchor: west; }'
fi
