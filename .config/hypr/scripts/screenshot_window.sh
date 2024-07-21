#!/bin/bash
# .config/hypr/scripts/screenshot_window.sh
# Screenshot a window Ctrl+Print

grim -g "$(hyprctl -t get_tree | jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | slurp)" - | swappy -f -
