#!/bin/bash

CUSTOM_DIRECTORIES_FILE="$USERDATA_DIR/custom-directories"

echo "Verifying and adding custom directory list..."

if [ ! -f "$CUSTOM_DIRECTORIES_FILE" ]; then
    echo "Creating '$CUSTOM_DIRECTORIES_FILE' with default directory '~'"
    echo "~" > "$CUSTOM_DIRECTORIES_FILE"
fi

file_contents=$(cat "$CUSTOM_DIRECTORIES_FILE")
eval_and_verify_directories "$file_contents"

if [[ -n "$file_contents" ]]; then
    echo -e "$verified_dirs" > "$DIRECTORY_SESSIONS_FILE"
fi

