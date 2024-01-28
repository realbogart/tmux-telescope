#!/bin/bash

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

preview_session() {
    session_name="$1"
    session_name_escaped=$(printf '%q' "$1")

    if tmux has-session -t "$session_name_escaped" 2>/dev/null; then
        tmux capture-pane -pe -t "$session_name_escaped"
    else
        echo "Session '$session_name' does not exist."
        echo "Select to create it."
    fi
}

