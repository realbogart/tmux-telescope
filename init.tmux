#!/usr/bin/env bash

CURRENT_SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source $CURRENT_SCRIPT_DIR/scripts/env.sh

if tmux show-option -g | grep -q "^@telescope-directory-sessions-bind"; then
    bind_key=$(tmux show-option -gqv @telescope-directory-sessions-bind)
    tmux bind-key "${bind_key}" display-popup -E "$SCRIPTS_DIR/directory-sessions.sh"
fi

if tmux show-option -g | grep -q "^@telescope-directory-refresh-bind"; then
    bind_key=$(tmux show-option -gqv @telescope-directory-refresh-bind)
    tmux bind-key "${bind_key}" run-shell "bash \"$SCRIPTS_DIR/directory-refresh.sh\""
fi

