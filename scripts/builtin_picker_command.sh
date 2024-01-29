#!/usr/bin/env bash

CURRENT_SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

source $CURRENT_SCRIPT_DIR/env.sh
source $CURRENT_SCRIPT_DIR/util.sh

rm -f "$TMP_BUILTIN_SELCTION"

tmux display-popup -E -T "builtin" "$SCRIPTS_DIR/picker.sh builtin"

if [ -f "$TMP_BUILTIN_SELCTION" ]; then
    selection=$(cat "$TMP_BUILTIN_SELCTION")
    rm -f "$TMP_BUILTIN_SELCTION"

    if [ -n "$selection" ]; then
        tmux display-popup -E -T "$selection" "$SCRIPTS_DIR/picker.sh $selection"
    fi
fi

