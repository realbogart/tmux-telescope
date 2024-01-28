#!/bin/bash

CUSTOM_FILE="$USERDATA_DIR/custom"

echo "Verifying and adding custom directory list..."

if [ ! -f "$CUSTOM_FILE" ]; then
    echo "Creating '$CUSTOM_FILE' with default directory '~'"
    echo "~" > "$CUSTOM_FILE"
fi

file_contents=$(cat "$CUSTOM_FILE")
eval_and_verify_directories "$file_contents"

if [[ -n "$file_contents" ]]; then
    echo -e "$verified_dirs" > "$DIRECTORY_SESSIONS_FILE"
fi

