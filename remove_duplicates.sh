#!/bin/bash

# Check if the correct number of parameters is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <input_file>"
    exit 1
fi

# Input file containing duplicate file paths (parameter 1)
input_file="$1"

# Check if the input file exists
if [ ! -f "$input_file" ]; then
    echo "Input file not found: $input_file"
    exit 1
fi

# Read each line from the input file and remove the corresponding file
while IFS= read -r file_path; do
    # Check if the file exists before attempting to remove it
    if [ -f "$file_path" ]; then
        rm "$file_path"
        echo "Removed: $file_path"
    else
        echo "File not found: $file_path"
    fi
done < "$input_file"
