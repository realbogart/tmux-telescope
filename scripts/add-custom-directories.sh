#!/bin/bash

CURRENT_SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

source $CURRENT_SCRIPT_DIR/env.sh
source $CURRENT_SCRIPT_DIR/util.sh

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

