#!/bin/bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
USERDATA_DIR=$SCRIPT_DIR/../userdata
CACHE_DIR=$SCRIPT_DIR/../cache
DIRECTORY_SESSIONS_FILE="$CACHE_DIR/directory-sessions"

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

source $SCRIPT_DIR/add-custom-directories.sh
source $SCRIPT_DIR/find-git-repositories.sh

echo "Done!"

