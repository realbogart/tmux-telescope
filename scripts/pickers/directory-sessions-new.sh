#!/bin/bash

picker_init () {
    if [ ! -f "$DIRECTORY_SESSIONS_FILE" ]; then
        "$SCRIPTS_DIR/directory-refresh.sh"
    fi
}

picker_list () {
    cat "$DIRECTORY_SESSIONS_FILE" | sed "s|^$HOME|~|g"
}

picker_preview () {
    session_name="$1"
    session_name_escaped=$(printf '%q' "$1")

    if tmux has-session -t "$session_name_escaped" 2>/dev/null; then
        tmux capture-pane -pe -t "$session_name_escaped"
    else
        echo "Session '$session_name' does not exist."
        echo "Select to create it."
    fi
}

picker_select () {
    selected_dir=$1
    selected_dir_expanded=$(echo "$1" | sed "s|^~|$HOME|g")

    session_name="$selected_dir"
    session_name_escaped=$(printf '%q' "$session_name")

    if [ -z "$selected_dir" ]; then
        exit 0
    fi

    if tmux has-session -t "$session_name" 2>/dev/null; then
        if [ -n "$TMUX" ]; then
            tmux switch-client -t "$session_name_escaped"
        else
            tmux attach-session -t "$session_name_escaped"
        fi
    else
        tmux new-session -d -s "$session_name" -c "$selected_dir_expanded"
        if [ -n "$TMUX" ]; then
            tmux switch-client -t "$session_name_escaped"
        else
            tmux attach-session -t "$session_name_escaped"
        fi
    fi
}

