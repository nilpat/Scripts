#!/bin/bash

# Declare variables with clear names
source_dir="/path/to/source/files"
target_user="username"
target_host="remote_server_hostname_or_IP"
target_dir="/path/to/destination/directory"

# Ensure source directory exists
if [[ ! -d "$source_dir" ]]; then
  echo "Error: Source directory does not exist."
  exit 1
fi

# Use rsync for efficient and secure transfer
rsync -avhP --stats \
  --delete  # Delete files in target that are not present in source
  --exclude=".*"  # Exclude hidden files
  "$source_dir"/ "$target_user@$target_host:$target_dir"

# Check for errors
if [[ $? -ne 0 ]]; then
  echo "Error: File transfer failed."
  exit 1
else
  echo "Files transferred successfully."
fi
