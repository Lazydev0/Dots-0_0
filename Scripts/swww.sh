#!/bin/bash

# Define the directories for colorful and black-and-white wallpapers
COLOR_DIR="$HOME/Pictures/Colourful/"
BW_DIR="$HOME/Pictures/Gray/"
TRACKING_FILE="$HOME/Pictures/Screenshots/Variables/wallpaper_tracking.txt"

# Determine the current wallpaper displayed by swww
CURRENT_WALLPAPER=$(swww query | grep "currently displaying:" | awk -F 'image: ' '{print $2}')

# Check if the current wallpaper is in the colorful directory
if [[ "$CURRENT_WALLPAPER" == "$COLOR_DIR"* ]]; then
  PICS=("$COLOR_DIR"/*)
  CACHEDIR="$HOME/.cache/rofi_icons/"
  BLURREDDIR="$HOME/Pictures/Color_Blurred/"
else
  PICS=("$BW_DIR"/*)
  CACHEDIR="$HOME/.cache/rofi_greyicons/"
  BLURREDDIR="$HOME/Pictures/Gray_Blurred/"
fi

RANDOMPIC="${PICS[RANDOM % ${#PICS[@]}]}"
BASENAME=$(basename "$RANDOMPIC")

# Initialize swww if it isn't already running
swww query || swww init

# Change the wallpaper using swww with the specified transition parameters
swww img "$RANDOMPIC" --transition-bezier .43,1.19,1,.4 --transition-fps 144 --transition-type grow --transition-duration 1 --transition-pos 0.680,1 &&
  dunstify "Wallpaper switched to $BASENAME" -i "${CACHEDIR}/${BASENAME}"

# Save the current wallpaper name
echo "$BASENAME" >"$TRACKING_FILE"

# Update the rofi config with the new wallpaper
IMAGE1="background-image: url(\"${RANDOMPIC}\",width);"
sed -i "s#background-image:.*#${IMAGE1}#" "$HOME/.config/rofi/menu.rasi"

# Update the hyprlock config with the blurred wallpaper path
sed -i "s#path=.*#path=$BLURREDDIR/$BASENAME#" "$HOME/.config/hypr/hyprlock.conf"
