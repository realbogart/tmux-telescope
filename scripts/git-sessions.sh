#!/bin/bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
CACHE_DIR="$SCRIPT_DIR/../cache"
SOURCES_DIR="$SCRIPT_DIR/../sources"
SESSIONS_FILE="$CACHE_DIR/sessions"
PREVIEW_SCRIPT="$SCRIPT_DIR/preview-session.sh"

if [ ! -f "$SESSIONS_FILE" ]; then
    "$SCRIPT_DIR/git-refresh.sh"
fi

selected_dir=$(cat "$SESSIONS_FILE" | sed "s|^$HOME|~|g" | fzf --layout=reverse -i --ansi --preview "$PREVIEW_SCRIPT {}")
selected_dir_expanded=$(echo "$selected_dir" | sed "s|^~|$HOME|g")

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

