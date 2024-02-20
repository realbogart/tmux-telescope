#!/usr/bin/env bash

picker_list () {
    for picker_script in "$PICKERS_DIR"/*.sh; do
        if [ -f "$picker_script" ]; then
            picker_name=$(basename $picker_script | sed 's/\.sh$//')
            if [ "$picker_name" != "builtin" ]; then
                echo "$picker_name"
            fi
        fi
    done
}

picker_select () {
    echo $1 > $TMP_BUILTIN_SELCTION
}

