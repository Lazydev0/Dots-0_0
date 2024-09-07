#!/bin/bash

PATTERN_DIR="$HOME/.config/pattern/"
PREV_PATTERN_FILE="$HOME/Pictures/Screenshots/Variables/trackPattern.txt"

# Get a list of all patterns in the directory
PATTERN=("$PATTERN_DIR"/*)

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
viu -w 32 -h 15 "$RANDPATTERN"
