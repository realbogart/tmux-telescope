#!/bin/bash

CURRENT_SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source $CURRENT_SCRIPT_DIR/env.sh
source $CURRENT_SCRIPT_DIR/util.sh

if [ ! -d "$CACHE_DIR" ]; then
    mkdir -p "$CACHE_DIR"
fi

if [ ! -d "$USERDATA_DIR" ]; then
    mkdir -p "$USERDATA_DIR"
fi

> $DIRECTORY_SESSIONS_FILE

$SCRIPTS_DIR/add-custom-directories.sh
$SCRIPTS_DIR/find-git-repositories.sh

echo "Done!"

