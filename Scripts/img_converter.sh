#!/bin/bash

while true; do
  read -n 1 -p "Would you like to upload a directory or a file? (d/f) " var_type
  echo " "

  if [[ $var_type == 'f' ]]; then
    read -e -p "Enter the path to the file: " file_path
    dir_path=$(dirname "$file_path")
    file_name=$(basename "$file_path")
    cd "$dir_path" || {
      echo "Failed to change directory to $dir_path"
      exit 1
    }
    output_file="${file_name%.*}(1).${file_name##*.}"
    magick "$file_name" -colorspace Gray "$output_file"
    sleep 2
    echo -e "\nConversion complete. Gray image saved as $output_file in \n$dir_path\n"

  elif [[ $var_type == 'd' ]]; then
    read -e -p "Enter the path to the input folder: " input_dir
    read -e -p "Enter the path to the output folder: " output_dir
    mkdir -p "$output_dir"
    for image in "$input_dir"/*; do
      file_name=$(basename "$image")
      magick "$image" -colorspace Gray "$output_dir/$file_name"
    done
    sleep 2
    echo -e "\nConversion complete. Gray images saved in $output_dir.\n"

  else
    echo "Invalid choice."
  fi

  read -n 1 -p "Would you like to try again? (y/n) " result
  echo " "
  if [[ $result != 'y' ]]; then
    break
  fi
done
