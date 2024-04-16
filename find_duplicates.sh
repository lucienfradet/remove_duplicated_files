#!/bin/bash

# Function to recursively search for files in a directory
find_files() {
    local dir="$1"
    local pattern="$2"
    find "$dir" -type f -name "$pattern"
}

# Check if the correct number of parameters is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <directory> <file_pattern> <output_path>"
    exit 1
fi

# Directory to search (parameter 1)
search_dir="$1"

# File pattern to search for (parameter 2)
file_pattern="$2"

# Output path for duplicates.txt (parameter 3)
output_path="$3"

# Array to store file names
file_array=()

# Populate the file array with file names
while IFS= read -r file; do
    file_array+=("$file")
done < <(find_files "$search_dir" "$file_pattern")

# Function to check for duplicates and write paths to the output file
check_duplicates() {
    local array=("$@")
    local dup_file="$output_path"

    # Associative array to track duplicates
    declare -A seen_files

    for file in "${array[@]}"; do
        # Get the file name without the path
        filename=$(basename "$file")

        # Check if the filename exists in the associative array
        if [[ -n "${seen_files[$filename]}" ]]; then
            # Write the path to the duplicate file in the output file
            echo "$file" >> "$dup_file"
        else
            # Add the filename to the associative array
            seen_files[$filename]=1
        fi
    done
}

# Call the check_duplicates function with the file array
check_duplicates "${file_array[@]}"
