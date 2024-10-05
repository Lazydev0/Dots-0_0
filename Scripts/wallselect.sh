#!/bin/bash

for app in imagemagick; do
  if ! pacman -Q $app >/dev/null 2>&1; then
    dunstify "Missing package" "Please install the $app package to continue" -u critical
    exit 1
  fi
done

# Set some variables
COLORDIR=$HOME/Pictures/Colourful/
GRAYDIR=$HOME/Pictures/Gray/
WALL_DIR="/home/nyx/Pictures/Colourful/"
CACHE_DIR="/home/nyx/.cache/rofi_icons/"
ROFI_EXECUTE="rofi -dmenu -theme ${HOME}/.config/rofi/wallselect.rasi -theme-str ${ROFI_OVERRIDE}"
TRACKING_FILE="$HOME/Pictures/Screenshots/Variables/wallpaper_tracking.txt"

MOITOR_RES=$(hyprctl monitors | grep -m1 "res: " | awk '{print $4}' | cut -d 'x' -f1)
MONITOR_SCALE=$(hyprctl monitors | grep -m1 "scale: " | awk '{print $2}')
MOITOR_RES=$((MOITOR_RES * 17 / MONITOR_SCALE))
ROFI_OVERRIDE="element-icon{size:${MOITOR_RES}px;border-radius:0px;}"

# Create cache dir if not exists
if [ ! -d "${CACHE_DIR}" ]; then
  mkdir -p "${CACHE_DIR}"
fi

# Convert images in directory and save to cache dir
for imagen in "$WALL_DIR"/*.{jpg,jpeg,png,webp}; do
  [ -f "$imagen" ] || continue
  nombre_archivo=$(basename "$imagen")
  [ -f "${CACHE_DIR}/${nombre_archivo}" ] || magick "$imagen" -resize 500x500^ -gravity center -extent 500x500 "${CACHE_DIR}/${nombre_archivo}"
done

# Launch rofi
SELECTION=$(find "${WALL_DIR}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -exec basename {} \; | sort | while read -r A; do echo -en "$A\x00icon\x1f""${CACHE_DIR}"/"$A\n"; done | $ROFI_EXECUTE)
BASENAME=$(basename "$SELECTION")

if [[ -n "$SELECTION" ]]; then
  # Set wallpaper
  swww query || swww init

  # Change the wallpaper using swww with the specified transition parameters
  swww img "${WALL_DIR}${BASENAME}" --transition-bezier .43,1.19,1,.4 --transition-fps 144 --transition-type grow --transition-duration 1 --transition-pos 0.680,1 && dunstify "Wallpaper changed to $BASENAME" -i "${CACHE_DIR}${BASENAME}"

  # Save the current wallpaper name
  echo "$BASENAME" >"$TRACKING_FILE"

  if [[ "$WALL_DIR" == "$COLORDIR"* ]]; then
    BLURREDDIR=$HOME/Pictures/Color_Blurred
  else
    BLURREDDIR=$HOME/Pictures/Gray_Blurred
  fi

  # Update the rofi config with the new wallpaper
  IMAGE1="background-image: url(\"${WALL_DIR}${BASENAME}\",width);"
  sed -i "s#background-image:.*#${IMAGE1}#" "$HOME/.config/rofi/menu.rasi"
  sed -i "s#path=.*#path=$BLURREDDIR/$BASENAME#" "$HOME/.config/hypr/hyprlock.conf"

else
  echo "No selection made in Rofi."
fi
