#!/usr/bin/env bash

info=$(hyprctl activewindow -j)
floating=$(echo "$info" | jq -r '.floating')

if [[ "$floating" == "false" || "$floating" == "0" || -z "$floating" ]]; then
  hyprctl dispatch togglefloating
  sleep 0.07
  hyprctl dispatch resizeactive exact 1200 700
  hyprctl dispatch centerwindow
else
  hyprctl dispatch togglefloating
fi
