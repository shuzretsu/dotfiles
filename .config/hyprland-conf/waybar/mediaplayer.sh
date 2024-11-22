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

#ver 2

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
        echo " "  # Spotify icon when no song is playing
        return  # Return and exit the function if no song is playing
    else
        # Simulate scrolling by shifting the song title
        scroll_text="| $song"
        len=${#scroll_text}

        # Scroll the song title
        for ((i=0; i<$len; i++)); do
            echo "${scroll_text:$i} ${scroll_text:0:$i}"
            sleep 0.3  # Adjust the speed of scrolling
        done
    fi
}

# Keep the script running and update every 5 seconds
while true; do
    scroll_song
    sleep 0.2 # Update every 5 seconds
done
