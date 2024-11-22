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


#dumb

#!/bin/bash

if ! command -v playerctl &> /dev/null; then
    echo "playerctl not found, please install it"
    exit 1
fi

# Initialize the last known song to detect changes
last_song=""

# Function to scroll or display the song title
scroll_song() {
    song=$(playerctl -p spotify metadata --format "{{artist}} - {{title}}")

    # If no song is playing, show the Spotify icon
    if [ -z "$song" ]; then
        echo " "  # Spotify icon
        return
    fi

    # If the song has changed, reset the scroll position
    if [ "$song" != "$last_song" ]; then
        last_song="$song"
        scroll_position=0
    fi

    # Determine if scrolling is needed
    if [ ${#song} -gt 25 ]; then
        # Scroll the song title dynamically
        scroll_text="$song | $song"  # Create a repeating scroll text
        visible_text="${scroll_text:$scroll_position:25}"  # Get the visible portion
        echo "$visible_text"  # Output the visible portion to Waybar
        ((scroll_position++))  # Increment the scroll position
        if [ $scroll_position -ge ${#song} ]; then
            scroll_position=0  # Reset the scroll position when the end is reached
        fi
    else
        # Display static song title if <= 25 characters
        echo "$song"
    fi
}

# Initialize scroll position
scroll_position=0

# Main loop to continuously update Waybar
while true; do
    scroll_song
    sleep 0.2  # Adjust the refresh rate as needed
done
