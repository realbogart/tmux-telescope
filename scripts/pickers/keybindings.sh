#!/bin/bash

PICKER_OPT_WRAP="wrap"

picker_list() {
    tmux list-keys | awk '$2 == "-T" && $4 != "" {print $3, $4}'
}

picker_preview() {
    echo $(tmux list-keys -T $1 $2)
}

picker_select() {
    selected_keybinding=$1

    if [ -z "$selected_keybinding" ]; then
        exit 0
    fi

    echo "Selected keybinding: $selected_keybinding"
}

