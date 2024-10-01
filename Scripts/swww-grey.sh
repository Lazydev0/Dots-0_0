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

CURRENT_WALLPAPER=$(swww query | grep "currently displaying:" | awk -F 'image: ' '{print $2}')

if [[ "$CURRENT_WALLPAPER" == "$COLOR_DIR"* ]]; then
  NEW_WALLPAPER="$BW_WALLPAPER"
  CACHEDIR=~/.cache/rofi_greyicons/
else
  NEW_WALLPAPER="$COLOR_WALLPAPER"
  CACHEDIR=~/.cache/rofi_icons/
fi

if [[ "$CURRENT_WALLPAPER" == "/home/nyx/Pictures/Colourful/"* ]]; then
  sed -i 's|WALL_DIR="${HOME}/Pictures/Colourful/"|WALL_DIR="${HOME}/Pictures/Gray/"|' ~/Scripts/wallselect.sh
  sed -i 's|CACHE_DIR="${HOME}/.cache/rofi_icons/"|CACHE_DIR="${HOME}/.cache/rofi_greyicons/"|' ~/Scripts/wallselect.sh
else
  sed -i 's|WALL_DIR="${HOME}/Pictures/Gray/"|WALL_DIR="${HOME}/Pictures/Colourful/"|' ~/Scripts/wallselect.sh
  sed -i 's|CACHE_DIR="${HOME}/.cache/rofi_greyicons/"|CACHE_DIR="${HOME}/.cache/rofi_icons/"|' ~/Scripts/wallselect.sh
fi

# Initialize swww if it isn't already running
swww query || swww init

# Change the wallpaper using swww with the specified transition parameters
swww img "$NEW_WALLPAPER" --transition-bezier .43,1.19,1,.4 --transition-fps 144 --transition-type grow --transition-duration 2 --transition-pos 0.680,1 && dunstify "Grayscale $BASENAME" -i "${CACHEDIR}/${BASENAME}"

# Save the current wallpaper name
echo "$BASENAME" >"$TRACKING_FILE"

# Update the rofi config with the new wallpaper
IMAGE1="background-image: url(\"${NEW_WALLPAPER}\",width);"
sed -i "s#background-image:.*#${IMAGE1}#" "$HOME/.config/rofi/menu.rasi"

IMAGE2="image=${NEW_WALLPAPER}"
sed -i "s#^image=.*#${IMAGE2}#" "$HOME/.config/swaylock/config"

IMAGE1="background-image: url(\"${NEW_WALLPAPER}\",width);"
sed -i "s#background-image:.*#${IMAGE1}#" "$HOME/.config/rofi/powermenu.rasi"
