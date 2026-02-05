#!/usr/bin/env zsh

SCREENSHOT_DIR="$HOME/Pictures/Screenshots"

mkdir -p "$SCREENSHOT_DIR" || {
  echo "Error: Failed to create directory."
  exit 1
}

LAST_AREA=$(ls -1 "$SCREENSHOT_DIR" | grep -E '^Area_[0-9]+\.png$' | sort -V | tail -n 1)

if [ -z "$LAST_AREA" ]; then
  LAST_NUMBER=0
else
  LAST_NAME=${LAST_AREA%.png}
  LAST_NUMBER=${LAST_NAME#Area_}
fi

NEXT_NUMBER=$((LAST_NUMBER + 1))
FILE="$SCREENSHOT_DIR/Area_$NEXT_NUMBER.png"

if ! command -v "grimblast" &>/dev/null; then
   echo "Error: grimblast not found."
   exit 1
fi

grimblast copysave area "${FILE}" && \
notify-send "Area captured" "Saved to: $FILE" -i "$FILE"

