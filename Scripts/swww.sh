#!/bin/bash

# Define the directories for colorful and black-and-white wallpapers
COLOR_DIR="$HOME/Pictures/Colourful/"
BW_DIR="$HOME/Pictures/Gray/"
# Define the path to the file storing the last wallpaper name
TRACKING_FILE="$HOME/Pictures/Screenshots/Variables/wallpaper_tracking.txt"

# Determine the current wallpaper displayed by swww
CURRENT_WALLPAPER=$(swww query | grep "currently displaying:" | awk -F 'image: ' '{print $2}')

# Check if the current wallpaper is in the colorful directory
if [[ "$CURRENT_WALLPAPER" == "$COLOR_DIR"* ]]; then
  # It's currently displaying a colorful wallpaper, select a random wallpaper from the colorful directory
  PICS=("$COLOR_DIR"/*)
else
  # It's currently displaying a grayscale wallpaper, select a random wallpaper from the grayscale directory
  PICS=("$BW_DIR"/*)
fi

# Select a random wallpaper from the list
RANDOMPICS="${PICS[RANDOM % ${#PICS[@]}]}"
BASENAME=$(basename "$RANDOMPICS")

# Initialize swww if it isn't already running
swww query || swww init

# Change the wallpaper using swww with the specified transition parameters
swww img "$RANDOMPICS" --transition-bezier .43,1.19,1,.4 --transition-fps 144 --transition-type grow --transition-duration 2 --transition-pos 0.680,0.970

# Save the current wallpaper name
echo "$BASENAME" >"$TRACKING_FILE"

# Update the rofi config with the new wallpaper
IMAGE1="background-image: url(\"${RANDOMPICS}\",width);"
sed -i "s#background-image:.*#${IMAGE1}#" "$HOME/.config/rofi/menu.rasi"

IMAGE2="image=${RANDOMPICS}"
sed -i "s#^image=.*#${IMAGE2}#" "$HOME/.config/swaylock/config"
