#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")
SCRIPT_DIR=$(cd "$SCRIPT_DIR" && pwd)

if tmux show-option -g | grep -q "^@telescope-directory-sessions-bind"; then
    bind_key=$(tmux show-option -gqv @telescope-directory-sessions-bind)
    tmux bind-key "${bind_key}" display-popup -E "$SCRIPT_DIR/scripts/directory-sessions.sh"
fi

if tmux show-option -g | grep -q "^@telescope-directory-refresh-bind"; then
    bind_key=$(tmux show-option -gqv @telescope-directory-refresh-bind)
    tmux bind-key "${bind_key}" run-shell "bash \"$SCRIPT_DIR/scripts/directory-refresh.sh\""
fi

