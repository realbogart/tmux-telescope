#!/bin/bash

CURRENT_SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

source $CURRENT_SCRIPT_DIR/env.sh

eval_and_verify_directories() {
    local input="$1"
    verified_dirs=""

    IFS=$'\n' read -rd '' -a lines <<< "$input"

    for line in "${lines[@]}"; do
        local expanded_line
        expanded_line=$(eval echo "$line")

        if [ -d "$expanded_line" ]; then
            verified_dirs+="${expanded_line}"$'\n'
        else
            echo "Directory $expanded_line not found, skipping..."
        fi
    done

    verified_dirs=$(echo "$verified_dirs" | awk 'NF')
}

find_git_dirs() {
    local dir_path="$1"
    find "$dir_path" -name ".git" | sed 's/\.git$//'
}

preview_pane() {
    session_name="$1"
    window="$2"
    pane="$3"
    session_name_escaped=$(printf '%q' "$1")

    target="$session_name_escaped"
    if [ -n "$window" ] && [ -n "$pane" ]; then
        # If both window and pane are provided
        target="${target}:${window}.${pane}"
    elif [ -n "$window" ]; then
        # If only window is provided
        target="${target}:${window}"
    fi

    if tmux has-session -t "$session_name_escaped" 2>/dev/null; then
        tmux capture-pane -pe -t "$target"
    else
        echo "Session '$session_name' does not exist."
        echo "Select to create it."
    fi
}

open_picker_cmd() {
    picker_name="$1"
    echo "display-popup -T '$picker_name' -E $SCRIPTS_DIR/picker.sh $picker_name"
}

