import os
import shutil

# Prompt the user for the target directory
target_dir = input("Enter the target directory: ")

# Make sure the target directory exists
if not os.path.isdir(target_dir):
  print("Error: target directory does not exist")
  exit(1)

# Find all files in the current directory and its subdirectories, excluding the script itself
files = []
for root, dirs, filenames in os.walk("."):
    for filename in filenames:
        if filename != "copy_files.py":
            files.append(os.path.join(root, filename))

# Flag to track whether any files were copied
copied = False

# Copy each file to the target directory
for file in files:
  # Check if a file with the same name exists in the target directory
  if os.path.isfile(os.path.join(target_dir, file)):
    # Prompt the user to choose whether to overwrite or skip the copy
    while True:
      answer = input(f"File {file} already exists in the target directory. Do you want to overwrite it? (Yes/No) ")
      if answer in ['Yes', 'yes', 'Y', 'y']:
        shutil.copy(file, target_dir)
        copied = True
        break
      elif answer in ['No', 'no', 'N', 'n']:
        break
      else:
        print("Please enter Yes or No")
  else:
    shutil.copy(file, target_dir)
    copied = True

# Echo a different message depending on whether any files were copied
if copied:
  print("Files copied successfully")
else:
  print("No files were copied")
