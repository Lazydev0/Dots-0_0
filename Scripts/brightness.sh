#!/bin/sh

# Increment, decrement, or get the current brightness using brightnessctl and send a notification

case $1 in
up)
  brightnessctl set +5%
  ;;
down)
  brightnessctl set 5%-
  ;;
esac

BRIGHTNESS=$(brightnessctl get)
MAX_BRIGHTNESS=$(brightnessctl max)
PERCENTAGE=$((BRIGHTNESS * 100 / MAX_BRIGHTNESS))

send_notification() {
  ICON=~/.local/share/icons/Custom/creative.png
  TEXT="Brightness: ${PERCENTAGE}%"

  dunstify -a "Brightness" -r 9994 -h int:value:"$PERCENTAGE" -i "$ICON" "Brightness" "$TEXT" -t 2000
}

send_notification
