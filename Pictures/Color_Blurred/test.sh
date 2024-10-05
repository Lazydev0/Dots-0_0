#!/bin/bash

# Source and destination directories
src_dir=~/Pictures/Gray
dest_dir=~/Pictures/Gray_Blurred

# Loop through all .jpeg files in the source directory
for img in "$src_dir"/*.jpeg; do
  # Extract the filename
  filename=$(basename "$img")

  # Use ImageMagick to blur the image
  magick "$img" -blur 0x15 "$dest_dir/$filename"

  echo "Blurred: $filename"
done
