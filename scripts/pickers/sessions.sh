#!/usr/bin/env bash

picker_list () {
    tmux list-sessions -F "#{session_name}"
}

picker_preview () {
    preview_pane "$1"
}

picker_select () {
    selected_session=$1

    if tmux has-session -t "$selected_session" 2>/dev/null; then
        if [ -n "$TMUX" ]; then
            tmux switch-client -t "$selected_session"
        else
            tmux attach-session -t "$selected_session"
        fi
    fi
}

