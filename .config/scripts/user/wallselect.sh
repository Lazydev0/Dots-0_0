#!/bin/bash

for app in imagemagick; do
  if ! pacman -Q $app >/dev/null 2>&1; then
    dunstify "Missing package" "Please install the $app package to continue" -u critical
    exit 1
  fi
done

ROFI_EXECUTE="rofi -dmenu -theme ${HOME}/.config/rofi/wallselect.rasi"
WALL_DIR="$HOME/.config/wall.d/"
CACHE_DIR="$HOME/.cache/wall_cache/wallselect_icons/"
ROFI_DIR="$HOME/.cache/wall_cache/menu_icon/"
LOCKSCREEN_DIR="$HOME/.cache/wall_cache/lockscreen_images/"

if [ ! -d "$WALL_DIR" ] || [ ! -d "$CACHE_DIR" ] || [ ! -d "$ROFI_DIR" ] || [ ! -d "$LOCKSCREEN_DIR" ]; then
  mkdir -p "$WALL_DIR" "$CACHE_DIR" "$ROFI_DIR" "$LOCKSCREEN_DIR"
fi

for image in "$WALL_DIR"/*.{jpg,jpeg,png,webp}; do
  [ -f "$image" ] || continue
  rofi_icon=$(basename "$image")
  [ -f "${CACHE_DIR}/${rofi_icon}" ] || magick "$image" -resize 500x500^ -gravity center -extent 500x500 "${CACHE_DIR}/${rofi_icon}"
done

SELECTION=$(find "$WALL_DIR" -type f -iname "*.png" -exec basename {} \; | sort | while read -r A; do echo -en "$A\x00icon\x1f${CACHE_DIR}/$A\n"; done | $ROFI_EXECUTE)
BASENAME=$(basename "$SELECTION")

if [[ -n "$SELECTION" ]]; then

  swww query || swww init

  swww img "${WALL_DIR}${BASENAME}" \
    --transition-type grow \
    --transition-bezier .4,0,.2,1 \
    --transition-duration 0.6 \
    --transition-fps 144 \
    --transition-pos 0.680,1

  cp "${WALL_DIR}${BASENAME}" "$ROFI_DIR/rofi.png"
  cp "${WALL_DIR}${BASENAME}" "$LOCKSCREEN_DIR/lock.png"
else
  echo "No selection made in Rofi."
fi
