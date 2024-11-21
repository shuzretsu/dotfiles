#!/bin/bash

visible_width=15

escape_ampersand() {
    echo "$1" | sed 's/&/\&amp;/g'
}
song=$(playerctl -p spotify metadata --format "{{artist}} - {{title}}")

if [ -z "$song" ]; then
    echo ""  
    exit 0
else
    song=$(escape_ampersand "$song")
    scroll_text="   $song   $song   "

    while true; do
        for ((i = 0; i < ${#scroll_text}; i++)); do
            scrolling_text="${scroll_text:i:visible_width}"
            echo "$scrolling_text"
            sleep 0.2
        done
    done
fi
