#!/bin/bash

session_name="$1"
session_name_escaped=$(printf '%q' "$1")

if tmux has-session -t "$session_name_escaped" 2>/dev/null; then
    tmux capture-pane -pe -t "$session_name_escaped"
else
    echo "Session '$session_name' does not exist."
    echo "Select to create it."
fi

