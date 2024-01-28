#!/bin/bash

CURRENT_SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source $CURRENT_SCRIPT_DIR/env.sh
source $CURRENT_SCRIPT_DIR/util.sh

if [ ! -f "$GITROOTS_FILE" ]; then
    echo "Creating '$GITROOTS_FILE' with default directory '~'"
    echo "~" > "$GITROOTS_FILE"
fi

find_git_dirs() {
    local dir_path="$1"
    find "$dir_path" -name ".git" | sed 's/\.git$//'
}

file_contents=$(cat "$GITROOTS_FILE")
eval_and_verify_directories "$file_contents"

git_dirs=""
while IFS= read -r dir; do
    echo "Finding Git repositories from '$dir'"

    if [[ -n "$git_dirs" ]]; then
        git_dirs+=$'\n'
    fi

    git_dirs+=$(find_git_dirs "$dir")
done <<< "$verified_dirs"

if [[ -n "$git_dirs" ]]; then
    echo "$git_dirs" >> "$DIRECTORY_SESSIONS_FILE"
fi

