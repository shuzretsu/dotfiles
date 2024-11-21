#!/bin/bash


if ! command -v playerctl &> /dev/null
then
    echo "playerctl not found, please install it"
    exit 1
fi

# Function to fetch and scroll the song title
scroll_song() {
    song=$(playerctl -p spotify metadata --format "{{artist}} - {{title}}")
    
    if [ -z "$song" ]; then
        echo ""  # No song playing
        exit 0
    else
        # Simulate scrolling by shifting the song title
        scroll_text="| $song"
        len=${#scroll_text}
        
        for ((i=0; i<$len; i++)); do
            echo "${scroll_text:$i} ${scroll_text:0:$i}"
            sleep 0.3  # Adjust the speed of scrolling
        done
    fi
}

# Continuously update the song every few seconds
while true; do
    scroll_song
    sleep 0
done
