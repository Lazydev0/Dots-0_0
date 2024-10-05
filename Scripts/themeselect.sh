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

# Validate selection
if [[ -n "$SELECTION" ]]; then
  case "$SELECTION" in
  "Colourful_mode.png")
    NEW_WALLPAPER="${HOME}/Pictures/Colourful/$BASENAME"
    BLURREDDIR="${HOME}/Pictures/Color_Blurred/"
    ICONDIR="${HOME}/.cache/rofi_icons/"
    ;;
  "gray_mode.png")
    NEW_WALLPAPER="${HOME}/Pictures/Gray/$BASENAME"
    BLURREDDIR="${HOME}/Pictures/Gray_Blurred/"
    ICONDIR="${HOME}/.cache/rofi_greyicons/"
    ;;
  *)
    dunstify "Invalid selection"
    exit 1
    ;;
  esac

  # Initialize `swww` if not already running
  swww query || swww init

  # Change wallpaper with transition
  swww img "$NEW_WALLPAPER" --transition-bezier .43,1.19,1,.4 --transition-fps 144 --transition-type grow --transition-duration 1 --transition-pos 0.680,1 &&
    [[ "$NEW_WALLPAPER" == "$HOME/Pictures/Colourful/"* ]] && dunstify "Colorify $BASENAME" -i "${ICONDIR}${BASENAME}" || dunstify "Gratify $BASENAME" -i "${ICONDIR}${BASENAME}"

  # Save current wallpaper name
  echo "$BASENAME" >"$TRACKING_FILE"

  # Update rofi and hyprlock configs
  sed -i "s#background-image:.*#background-image: url(\"${NEW_WALLPAPER}\",width);#" "$HOME/.config/rofi/menu.rasi"
  sed -i "s#path=.*#path=$BLURREDDIR/$BASENAME#" "$HOME/.config/hypr/hyprlock.conf"

  # Update paths in wallpaper selection script
  sed -i "s|WALL_DIR=.*|WALL_DIR=\"${NEW_WALLPAPER%/*}/\"|" ~/Scripts/wallselect.sh
  sed -i "s|CACHE_DIR=.*|CACHE_DIR=\"$ICONDIR\"|" ~/Scripts/wallselect.sh
fi
