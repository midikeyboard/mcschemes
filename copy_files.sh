#!/bin/bash

# Prompt the user for the target directory
echo "Enter the target directory:"
read target_dir

# Make sure the target directory exists
if [ ! -d "$target_dir" ]; then
  echo "Error: target directory does not exist"
  exit 1
fi

# Find all files in the current directory and its subdirectories, excluding the script itself
files=$(find . -type f ! -name "copy_files.sh")

# Flag to track whether any files were copied
copied=0

# Copy each file to the target directory
for file in $files; do
  # Check if a file with the same name exists in the target directory
  if [ -f "$target_dir/$file" ]; then
    # Prompt the user to choose whether to overwrite or skip the copy
    while true; do
      echo "File $file already exists in the target directory. Do you want to overwrite it? (Yes/No)"
      read answer
      case $answer in
        [Yy]* ) cp "$file" "$target_dir" && copied=1 && break;;
        [Nn]* ) break;;
        * ) echo "Please enter Yes or No";;
      esac
    done
  else
    cp "$file" "$target_dir"
    copied=1
  fi
done

# Echo a different message depending on whether any files were copied
if [ $copied -eq 1 ]; then
  echo "Files copied successfully"
else
  echo "No files were copied"
fi
