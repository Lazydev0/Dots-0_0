#!/bin/bash

# Define the directories for colorful and black-and-white wallpapers
COLOR_DIR="$HOME/Pictures/Colourful/"
BW_DIR="$HOME/Pictures/Gray/"
# Define the path to the file storing the last wallpaper name
TRACKING_FILE="$HOME/Pictures/Screenshots/Variables/wallpaper_tracking.txt"

# Get the last wallpaper name
if [[ -f "$TRACKING_FILE" ]]; then
  BASENAME=$(cat "$TRACKING_FILE")
  COLOR_WALLPAPER="$COLOR_DIR/$BASENAME"
  BW_WALLPAPER="$BW_DIR/$BASENAME"
else
  echo "No wallpaper tracked yet."
  exit 1
fi

# Determine the current wallpaper displayed by swww
CURRENT_WALLPAPER=$(swww query | grep "currently displaying:" | awk -F 'image: ' '{print $2}')

# Check if the current wallpaper is in the colorful directory
if [[ "$CURRENT_WALLPAPER" == "$COLOR_DIR"* ]]; then
  # It's currently displaying a colorful wallpaper, switch to grayscale
  NEW_WALLPAPER="$BW_WALLPAPER"
else
  # It's currently displaying a grayscale wallpaper, toggle back to colorful
  NEW_WALLPAPER="$COLOR_WALLPAPER"
fi

if [[ "$CURRENT_WALLPAPER" == "/home/nyx/Pictures/Colourful/"* ]]; then
  sed -i 's|WALL_DIR="${HOME}/Pictures/Colourful/"|WALL_DIR="${HOME}/Pictures/Gray/"|' ~/Dots/Scripts/wallselect.sh
  sed -i 's|CACHE_DIR="${HOME}/.cache/rofi_icons/"|CACHE_DIR="${HOME}/.cache/rofi_greyicons/"|' ~/Dots/Scripts/wallselect.sh
else
  sed -i 's|WALL_DIR="${HOME}/Pictures/Gray/"|WALL_DIR="${HOME}/Pictures/Colourful/"|' ~/Dots/Scripts/wallselect.sh
  sed -i 's|CACHE_DIR="${HOME}/.cache/rofi_greyicons/"|CACHE_DIR="${HOME}/.cache/rofi_icons/"|' ~/Dots/Scripts/wallselect.sh
fi

# Initialize swww if it isn't already running
swww query || swww init

# Change the wallpaper using swww with the specified transition parameters
swww img "$NEW_WALLPAPER" --transition-bezier .43,1.19,1,.4 --transition-fps 144 --transition-type grow --transition-duration 2 --transition-pos 0.680,0.970

# Save the current wallpaper name
echo "$BASENAME" >"$TRACKING_FILE"

# Update the rofi config with the new wallpaper
IMAGE1="background-image: url(\"${NEW_WALLPAPER}\",width);"
sed -i "s#background-image:.*#${IMAGE1}#" "$HOME/.config/rofi/menu.rasi"

IMAGE2="image=${NEW_WALLPAPER}"
sed -i "s#^image=.*#${IMAGE2}#" "$HOME/.config/swaylock/config"
