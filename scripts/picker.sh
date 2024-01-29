#!/bin/bash

CURRENT_SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

source $CURRENT_SCRIPT_DIR/env.sh
source $SCRIPTS_DIR/util.sh

$SCRIPTS_DIR/setup.sh

picker_name=$1
picker_source="$PICKERS_DIR/$picker_name.sh"
PICKER_CACHE=$CACHE_DIR/$picker_name

source $picker_source

picker_preview_wrapper() {
    source $SCRIPTS_DIR/env.sh
    source $SCRIPTS_DIR/util.sh
    PICKER_CACHE=$CACHE_DIR/$picker_name
    picker_preview $1
}

if [ ! -f "$PICKER_CACHE" ]; then
    > $PICKER_CACHE
    picker_rebuild_cache
fi

if declare -f "picker_init" > /dev/null; then
    picker_init
fi

export SCRIPTS_DIR
export -f picker_preview picker_preview_wrapper
selected_entry=$(picker_list | fzf --layout=reverse -i --ansi --preview 'bash -c "picker_preview_wrapper {}"')

if [ -z "$selected_entry" ]; then
    exit 0
fi

picker_select "$selected_entry"

