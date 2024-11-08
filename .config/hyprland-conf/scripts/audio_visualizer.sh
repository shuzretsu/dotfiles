#!/bin/bash

# Use FFmpeg to grab the PulseAudio stream and analyze frequencies
ffmpeg -f pulse -i default -filter_complex \
    "[0:a]aformat=channel_layouts=mono,showwavespic=s=128x1:scale=sqrt" \
    -frames:v 1 -f image2 - | convert - -resize 10x1\! txt:- | tail -n +2 \
    | awk '{print $3}' | cut -d '(' -f2 | cut -d ')' -f1 | while read -r color; do
        # Determine bar height (visualizer level) based on color value
        # You can expand this part to reflect various frequencies and intensities
        case "$color" in
            "#000000") BAR="▁" ;;
            "#404040") BAR="▂" ;;
            "#808080") BAR="▃" ;;
            "#C0C0C0") BAR="▄" ;;
            "#FFFFFF") BAR="▅" ;;
            *) BAR="▆" ;;   # Higher values, use full bar
        esac
        # Output the bar and tooltip as JSON for Waybar
        echo "{\"text\": \"$BAR\", \"tooltip\": \"Audio Visualizer\"}"
        sleep 0.1
    done
