#!/bin/bash

# Example positions for each XFCE Terminal
hyprctl dispatch exec "xfce4-terminal --role=term1"
sleep 0.2  # Small delay for window positioning
hyprctl dispatch movewindow pixel 0 0  # Move to top-left

hyprctl dispatch exec "xfce4-terminal --role=term2"
sleep 0.2
hyprctl dispatch movewindow pixel 1280 0  # Move to top-right

hyprctl dispatch exec "xfce4-terminal --role=term3"
sleep 0.2
hyprctl dispatch movewindow pixel 0 720  # Move to bottom-left

hyprctl dispatch exec "xfce4-terminal --role=term4"
sleep 0.2
hyprctl dispatch movewindow pixel 1280 720  # Move to bottom-right
