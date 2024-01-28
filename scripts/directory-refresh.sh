#!/bin/bash

CURRENT_SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source $CURRENT_SCRIPT_DIR/env.sh

eval_and_verify_directories() {
    local input="$1"
    verified_dirs=""

    IFS=$'\n' read -rd '' -a lines <<< "$input"

    for line in "${lines[@]}"; do
        local expanded_line
        expanded_line=$(eval echo "$line")

        if [ -d "$expanded_line" ]; then
            verified_dirs+="${expanded_line}"$'\n'
        else
            echo "Directory $expanded_line not found, skipping..."
        fi
    done

    verified_dirs=$(echo "$verified_dirs" | awk 'NF')
}

if [ ! -d "$CACHE_DIR" ]; then
    mkdir -p "$CACHE_DIR"
fi

if [ ! -d "$USERDATA_DIR" ]; then
    mkdir -p "$USERDATA_DIR"
fi

> $DIRECTORY_SESSIONS_FILE

source $SCRIPTS_DIR/add-custom-directories.sh
source $SCRIPTS_DIR/find-git-repositories.sh

echo "Done!"

