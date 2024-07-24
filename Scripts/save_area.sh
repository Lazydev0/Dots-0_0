#!/bin/bash

# Directory to save screenshots
screenshot_dir=~/Pictures/Screenshots

# File to store the last used screenshot number
last_number_file="$screenshot_dir/Variables/num_area.txt"

# Initialize the last number to 0 if the file does not exist
if [ ! -f "$last_number_file" ]; then
  echo 0 >"$last_number_file"
fi

# Read the last used screenshot number
last_number=$(cat "$last_number_file")

# Increment the number
next_number=$((last_number + 1))

# Save the next number back to the file
echo "$next_number" >"$last_number_file"

# Take the screenshot
grimblast save area "$screenshot_dir/Area_$next_number.png" && dunstify Selected\ area captured -i $HOME/.local/share/icons/Custom/Area_captured.png
