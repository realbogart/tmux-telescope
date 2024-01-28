#!/bin/bash

CURRENT_SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

source $CURRENT_SCRIPT_DIR/env.sh

$SCRIPTS_DIR/setup.sh

for picker_script in "$PICKERS_DIR"/*.sh; do
    if [ -f "$picker_script" ]; then
        source "$picker_script"

        if declare -f "picker_rebuild_cache" > /dev/null; then
            picker_rebuild_cache
        fi

        unset -f picker_rebuild_cache
    fi
done

