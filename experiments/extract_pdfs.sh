#!/bin/bash

# Usage: ./extract_pdfs.sh feature_name destination_folder
# Example: ./extract_pdfs.sh random_nan ./extracted_pdfs

# Check if sufficient parameters are provided
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 feature_name [destination_folder]"
    echo "Example: $0 random_nan ./extracted_pdfs"
    exit 1
fi

FEATURE_NAME=$1
DEST_FOLDER=${2:-"./extracted_pdfs"}  # Default destination folder is ./extracted_pdfs

# Create destination folder if it doesn't exist
mkdir -p "$DEST_FOLDER"

# Find the first subfolder within the feature folder
SUBFOLDER=$(find "$FEATURE_NAME" -maxdepth 1 -mindepth 1 -type d | head -n 1)

if [ -z "$SUBFOLDER" ]; then
    echo "Error: No subfolder found in '$FEATURE_NAME'"
    exit 1
fi

echo "Found subfolder: $SUBFOLDER"

# Define the profile directories to process
PROFILE_DIRS=(
    "data_history-based"
    "data_output-based"
    "perf_history-based"
    "perf_output-based"
)

# Copy and rename files
for PROFILE_DIR in "${PROFILE_DIRS[@]}"; do
    FULL_DIR="$SUBFOLDER/detailed_profiles/$PROFILE_DIR"
    
    if [ ! -d "$FULL_DIR" ]; then
        echo "Warning: Directory does not exist: $FULL_DIR"
        continue
    fi
    
    echo "Processing directory: $FULL_DIR"
    
    # Find and copy files ending with _1.pdf and _10.pdf
    find "$FULL_DIR" -name "*_1.pdf" -o -name "*_10.pdf" | while read PDF_FILE; do
        FILENAME=$(basename "$PDF_FILE")
        NEW_FILENAME="${FEATURE_NAME}_${FILENAME}"
        FEATURE_NAME_BASE=$(basename "$FEATURE_NAME")
        
        echo "Copying: $PDF_FILE -> $DEST_FOLDER/${FEATURE_NAME_BASE}_${FILENAME}"
        cp "$PDF_FILE" "$DEST_FOLDER/${FEATURE_NAME_BASE}_${FILENAME}"
    done
done

echo "Done! Files have been extracted to: $DEST_FOLDER"