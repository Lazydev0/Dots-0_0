#!/bin/bash

PATTERN_DIR="$HOME/.config/termArt/pokemon/"
PREV_PATTERN_FILE="$HOME/.cache/Trackers/trackPokemon.txt"

if [ -d "$PATTERN_DIR" ] && [ "$(ls -A "$PATTERN_DIR")" ]; then
  PATTERN=("$PATTERN_DIR"/*)
else
  echo "No patterns found in $PATTERN_DIR."
  exit 1
fi

if [ -f "$PREV_PATTERN_FILE" ]; then
  PREV_PATTERN=$(cat "$PREV_PATTERN_FILE")
else
  PREV_PATTERN=""
fi

while true; do
  RANDPATTERN="${PATTERN[RANDOM % ${#PATTERN[@]}]}"
  if [ "$RANDPATTERN" != "$PREV_PATTERN" ]; then
    break
  fi
done

echo "$RANDPATTERN" >"$PREV_PATTERN_FILE"

viu -h 20 "$RANDPATTERN"
