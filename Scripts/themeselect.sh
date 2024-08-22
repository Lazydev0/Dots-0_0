#!/bin/bash

for app in imagemagick; do
  if ! pacman -Q $app >/dev/null 2>&1; then
    dunstify "Missing package" "Please install the $app package to continue" -u critical
    exit 1
  fi
done

# Set some variables
CACHE_DIR="${HOME}/.cache/themeselect_icons/"
ROFI_EXECUTE="rofi -dmenu -theme ${HOME}/.config/rofi/themeselect.rasi -theme-str ${ROFI_OVERRIDE}"
TRACKING_FILE="$HOME/Pictures/Screenshots/Variables/wallpaper_tracking.txt"

MONITOR_RES=$(hyprctl monitors | grep -m1 "res: " | awk '{print $4}' | cut -d 'x' -f1)
MONITOR_SCALE=$(hyprctl monitors | grep -m1 "scale: " | awk '{print $2}')
MONITOR_RES=$((MONITOR_RES * 17 / MONITOR_SCALE))
ROFI_OVERRIDE="element-icon{size:${MONITOR_RES}px;border-radius:0px;}"

# Create cache dir if not exists
if [ ! -d "${CACHE_DIR}" ]; then
  mkdir -p "${CACHE_DIR}"
fi
CURRENT_WALLPAPER=$(swww query | grep "currently displaying:" | awk -F 'image: ' '{print $2}')
BASENAME=$(basename "$CURRENT_WALLPAPER")

if [[ "$CURRENT_WALLPAPER" == "/home/nyx/Pictures/Colourful/"* ]]; then
  NEW_WALLPAPER="${HOME}/Pictures/Gray/$BASENAME"
else
  NEW_WALLPAPER="${HOME}/Pictures/Colourful/$BASENAME"
fi

SELECTION=$(find "${CACHE_DIR}" -type f \( -iname "*.png" \) -exec basename {} \; | sort | while read -r A; do
  echo -en "$A\x00icon\x1f${CACHE_DIR}${A}\n"
done | $ROFI_EXECUTE)

if [[ -n "$SELECTION" ]]; then

  # Determine the new wallpaper based on the selected mode
  if [[ "$SELECTION" == "Colourful_mode.png" ]]; then
    NEW_WALLPAPER="${HOME}/Pictures/Colourful/$BASENAME"
  elif [[ "$SELECTION" == "gray_mode.png" ]]; then
    NEW_WALLPAPER="${HOME}/Pictures/Gray/$BASENAME"
  else
    echo "Invalid selection."
    exit 1
  fi
  swww query || swww init

  # Change the wallpaper using swww with the specified transition parameters
  swww img "${NEW_WALLPAPER}" --transition-bezier .43,1.19,1,.4 --transition-fps 144 --transition-type grow --transition-duration 2 --transition-pos 0.680,0.970

  # Save the current wallpaper name
  echo "$BASENAME" >"$TRACKING_FILE"

  # Update the rofi config with the new wallpaper
  IMAGE1="background-image: url(\"${NEW_WALLPAPER}\",width);"
  sed -i "s#background-image:.*#${IMAGE1}#" "$HOME/.config/rofi/menu.rasi"

  IMAGE1="background-image: url(\"${NEW_WALLPAPER}\",width);"
  sed -i "s#background-image:.*#${IMAGE1}#" "$HOME/.config/rofi/powermenu.rasi"

  IMAGE2="image=${NEW_WALLPAPER}"
  sed -i "s#^image=.*#${IMAGE2}#" "$HOME/.config/swaylock/config"

  if [[ "$CURRENT_WALLPAPER" == "/home/nyx/Pictures/Colourful/"* ]]; then
    sed -i 's|WALL_DIR="${HOME}/Pictures/Colourful/"|WALL_DIR="${HOME}/Pictures/Gray/"|' ~/Scripts/wallselect.sh
    sed -i 's|CACHE_DIR="${HOME}/.cache/rofi_icons/"|CACHE_DIR="${HOME}/.cache/rofi_greyicons/"|' ~/Scripts/wallselect.sh
  else
    sed -i 's|WALL_DIR="${HOME}/Pictures/Gray/"|WALL_DIR="${HOME}/Pictures/Colourful/"|' ~/Scripts/wallselect.sh
    sed -i 's|CACHE_DIR="${HOME}/.cache/rofi_greyicons/"|CACHE_DIR="${HOME}/.cache/rofi_icons/"|' ~/Scripts/wallselect.sh
  fi
fi
