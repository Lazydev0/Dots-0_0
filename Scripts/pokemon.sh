#!/bin/bash

PATTERN_DIR="$HOME/.config/termArt/pokemon/"
PREV_PATTERN_FILE="$HOME/Pictures/Screenshots/Variables/trackPokemon.txt"

# Check if pattern directory exists and contains files
if [ -d "$PATTERN_DIR" ] && [ "$(ls -A "$PATTERN_DIR")" ]; then
  # Get a list of all patterns in the directory
  PATTERN=("$PATTERN_DIR"/*)
else
  echo "No patterns found in $PATTERN_DIR."
  exit 1
fi

# Read the previous pattern from the file
if [ -f "$PREV_PATTERN_FILE" ]; then
  PREV_PATTERN=$(cat "$PREV_PATTERN_FILE")
else
  PREV_PATTERN=""
fi

# Loop to find a new unique pattern
while true; do
  RANDPATTERN="${PATTERN[RANDOM % ${#PATTERN[@]}]}"
  if [ "$RANDPATTERN" != "$PREV_PATTERN" ]; then
    break
  fi
done

# Save the selected pattern to the file
echo "$RANDPATTERN" >"$PREV_PATTERN_FILE"

# Display the pattern with viu
viu -h 20 "$RANDPATTERN"
