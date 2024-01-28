#!/bin/bash

SCRIPTS_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
USERDATA_DIR=$SCRIPTS_DIR/../userdata
CACHE_DIR=$SCRIPTS_DIR/../cache
PREVIEW_SCRIPT="$SCRIPTS_DIR/preview-session.sh"
CUSTOM_DIRECTORIES_FILE="$USERDATA_DIR/custom-directories"
GITROOTS_FILE="$USERDATA_DIR/gitroots"
DIRECTORY_SESSIONS_FILE="$CACHE_DIR/directory-sessions"

