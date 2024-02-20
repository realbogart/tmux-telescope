#!/usr/bin/env bash

CURRENT_SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

source $CURRENT_SCRIPT_DIR/env.sh
source $CURRENT_SCRIPT_DIR/util.sh

$SCRIPTS_DIR/setup.sh

for picker_script in "$PICKERS_DIR"/*.sh; do
    if [ -f "$picker_script" ]; then
        source "$picker_script"

        if declare -f "picker_rebuild_cache" > /dev/null; then
            picker_name=$(basename $picker_script | sed 's/\.sh$//')
            PICKER_CACHE=$CACHE_DIR/$picker_name

            echo "Rebuilding cache for $picker_name"
    
            > $PICKER_CACHE
            picker_rebuild_cache
        fi

        unset -f picker_rebuild_cache
    fi
done

echo "Finished rebuilding cache."
echo ""
echo "Press RETURN to close this window."

