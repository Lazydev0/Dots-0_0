#!/bin/bash

screenshot_dir=$HOME/Pictures/Screenshots

last_number_file="$screenshot_dir/Variables/num_screen.txt"

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
grimblast save screen "$screenshot_dir/Screen_$next_number.png"
