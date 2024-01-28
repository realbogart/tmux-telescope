#!/bin/bash

CUSTOM_FILE="$USERDATA_DIR/custom"

echo "Verifying and adding custom directory list..."

if [ -f "$CUSTOM_FILE" ]; then
    file_contents=$(cat "$CUSTOM_FILE")
    eval_and_verify_directories "$file_contents"
    echo -e "$verified_dirs" > "$DIRECTORY_SESSIONS_FILE"
else
    echo "'$CUSTOM_FILE' not found. Skipping."
fi

