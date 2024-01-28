#!/bin/bash

CURRENT_SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

source $CURRENT_SCRIPT_DIR/env.sh
source $SCRIPTS_DIR/util.sh

if [ ! -d "$CACHE_DIR" ]; then
    mkdir -p "$CACHE_DIR"
fi

if [ ! -d "$USERDATA_DIR" ]; then
    mkdir -p "$USERDATA_DIR"
fi

picker_source="$PICKERS_DIR/$1.sh"
source $picker_source

picker_preview_wrapper() {
    source $SCRIPTS_DIR/env.sh
    source $SCRIPTS_DIR/util.sh
    picker_preview $1
}

picker_init

export SCRIPTS_DIR
export -f picker_preview picker_preview_wrapper
selected_entry=$(picker_list | fzf --layout=reverse -i --ansi --preview 'bash -c "picker_preview_wrapper {}"')

if [ -z "$selected_entry" ]; then
    exit 0
fi

picker_select "$selected_entry"

