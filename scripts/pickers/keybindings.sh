#!/bin/bash

PICKER_OPT_WRAP="wrap"

picker_list() {
    tmux list-keys | awk '$2 == "-T" && $4 != "" {print $3, $4}'
}

picker_preview() {
    echo $(tmux list-keys -T $1 $2)
}

