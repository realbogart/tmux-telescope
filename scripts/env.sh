#!/usr/bin/env bash

SCRIPTS_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
USERDATA_DIR=$SCRIPTS_DIR/../userdata
CACHE_DIR=$SCRIPTS_DIR/../cache
TMP_BUILTIN_SELCTION=$CACHE_DIR/__builtin__
PICKERS_DIR=$SCRIPTS_DIR/pickers
PREVIEW_SCRIPT="$SCRIPTS_DIR/preview-session.sh"
CUSTOM_DIRECTORIES_FILE="$USERDATA_DIR/custom-directories"
GITROOTS_FILE="$USERDATA_DIR/gitroots"

