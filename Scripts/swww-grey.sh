#!/bin/bash

# Define directories for colorful and black-and-white wallpapers
COLOR_DIR="$HOME/Pictures/Colourful/"
BW_DIR="$HOME/Pictures/Gray/"
TRACKING_FILE="$HOME/Pictures/Screenshots/Variables/wallpaper_tracking.txt"
WALLSCRIPT="$HOME/Scripts/wallselect.sh"

# Check if the last wallpaper name exists
if [[ -f "$TRACKING_FILE" ]]; then
  BASENAME=$(cat "$TRACKING_FILE")
  COLOR_WALLPAPER="$COLOR_DIR/$BASENAME"
  BW_WALLPAPER="$BW_DIR/$BASENAME"
else
  echo "No wallpaper tracked yet."
  exit 1
fi

# Get the current wallpaper from swww
CURRENT_WALLPAPER=$(swww query | grep "currently displaying:" | awk -F 'image: ' '{print $2}')

# Determine the new wallpaper and corresponding directories
if [[ "$CURRENT_WALLPAPER" == "$COLOR_DIR"* ]]; then
  NEW_WALLPAPER="$BW_WALLPAPER"
  CACHEDIR="$HOME/.cache/rofi_greyicons/"
  BLURREDDIR="$HOME/Pictures/Gray_Blurred/"
  # Update paths in wallselect.sh for grayscale wallpapers
  sed -i "s|WALL_DIR=.*|WALL_DIR=\"$BW_DIR\"|" "$WALLSCRIPT"
  sed -i "s|CACHE_DIR=.*|CACHE_DIR=\"$CACHEDIR\"|" "$WALLSCRIPT"
else
  NEW_WALLPAPER="$COLOR_WALLPAPER"
  CACHEDIR="$HOME/.cache/rofi_icons/"
  BLURREDDIR="$HOME/Pictures/Color_Blurred/"
  # Update paths in wallselect.sh for colorful wallpapers
  sed -i "s|WALL_DIR=.*|WALL_DIR=\"$COLOR_DIR\"|" "$WALLSCRIPT"
  sed -i "s|CACHE_DIR=.*|CACHE_DIR=\"$CACHEDIR\"|" "$WALLSCRIPT"
fi

# Initialize swww if not already running
swww query || swww init

# Change the wallpaper with transition
swww img "$NEW_WALLPAPER" --transition-bezier .43,1.19,1,.4 --transition-fps 144 --transition-type grow --transition-duration 1 --transition-pos 0.680,1 &&
  [[ "$NEW_WALLPAPER" == "$HOME/Pictures/Colourful/"* ]] && dunstify "Colorify $BASENAME" -i "${CACHEDIR}${BASENAME}" || dunstify "Gratify $BASENAME" -i "${CACHEDIR}${BASENAME}"

# Update the wallpaper tracking file
echo "$BASENAME" >"$TRACKING_FILE"

# Update the rofi config with the new wallpaper
IMAGE1="background-image: url(\"$NEW_WALLPAPER\",width);"
sed -i "s#background-image:.*#${IMAGE1}#" "$HOME/.config/rofi/menu.rasi"

# Update the hyprlock config with the blurred wallpaper path
sed -i "s#path=.*#path=$BLURREDDIR/$BASENAME#" "$HOME/.config/hypr/hyprlock.conf"
