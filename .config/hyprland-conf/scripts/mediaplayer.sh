#!/bin/bash

if ! command -v playerctl &> /dev/null; then
    echo "playerctl not found, please install it"
    exit 1
fi

# Initialize the scroll position
scroll_position=0

# Function to fetch and scroll the song title
scroll_song() {
    song=$(playerctl -p spotify metadata --format "{{artist}} - {{title}} - {{album}}")

    if [ -z "$song" ]; then
        echo " "  # Spotify icon when no song is playing
        return  # Return and exit the function if no song is playing
    fi

    # Remove truncation, use full song title for scrolling
    scroll_text="| $song"
    len=${#scroll_text}

    # Output the visible portion of the song title
    visible_text="${scroll_text:$scroll_position} ${scroll_text:0:$scroll_position}"
    echo "$visible_text"

    # Move the scroll position
    ((scroll_position++))
    if [ $scroll_position -ge $len ]; then
        scroll_position=0  # Loop back to the beginning
    fi
}

# Main loop to continuously update Waybar and handle real-time updates
while true; do
    scroll_song
    sleep 0.2  # Adjust the speed of scrolling
done