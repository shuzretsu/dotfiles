#!/bin/bash

# Check if playerctl is installed
if ! command -v playerctl &> /dev/null
then
    echo "playerctl not found, please install it"
    exit 1
fi

# Fetch the song information (artist and title)
song=$(playerctl -p spotify metadata --format "{{artist}} - {{title}}")

if [ -z "$song" ]; then
    echo ""  # No song playing
    exit 0
else
    # Simulate scrolling by shifting the song title
    scroll_text="| $song"
    len=${#scroll_text}

    # Scroll the text with a delay
    while true; do
        for ((i=0; i<$len; i++)); do
            echo "${scroll_text:$i} ${scroll_text:0:$i}"
            sleep 0.2  # Adjust the speed of scrolling
        done
    done
fi
