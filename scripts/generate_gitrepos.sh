#!/bin/bash

GITROOTS_FILE="$USERDATA_DIR/gitroots"

echo "Generating Git repository list..."

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
    echo "Indexing Git repositories from '$dir'"

    if [[ -n "$git_dirs" ]]; then
        git_dirs+=$'\n'
    fi

    git_dirs+=$(find_git_dirs "$dir")
done <<< "$verified_dirs"

echo "$git_dirs" >> "$SESSIONS_FILE"

