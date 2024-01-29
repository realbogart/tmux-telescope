#!/usr/bin/env bash

CURRENT_SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "$CURRENT_SCRIPT_DIR/scripts/env.sh"
source "$CURRENT_SCRIPT_DIR/scripts/util.sh"

bind_tmux_key_if_set() {
    local option="$1"
    local command="$2"

    if tmux show-option -g | grep -q "^@${option}"; then
        local bind_key
        bind_key=$(tmux show-option -gqv "@${option}")
        tmux bind-key "$bind_key" "$command"
    fi
}

COMMAND_DIRECTORY_SESSIONS_PICKER="display-popup -E $SCRIPTS_DIR/picker.sh directory-sessions"
COMMAND_SESSIONS_PICKER="display-popup -E $SCRIPTS_DIR/picker.sh sessions"
COMMAND_KEYBINDINGS_PICKER="display-popup -E $SCRIPTS_DIR/picker.sh keybindings"
COMMAND_BUILTIN_PICKER="run-shell $SCRIPTS_DIR/builtin_picker_command.sh"
COMMAND_REFRESH="run-shell 'bash \"$SCRIPTS_DIR/rebuild-cache.sh\"'"
COMMAND_REBUILD_CACHE="run-shell 'bash \"$SCRIPTS_DIR/rebuild-cache.sh\"'"

bind_tmux_key_if_set "telescope-directory-sessions-bind" "$COMMAND_DIRECTORY_SESSIONS_PICKER"
bind_tmux_key_if_set "telescope-sessions-bind" "$COMMAND_SESSIONS_PICKER"
bind_tmux_key_if_set "telescope-keybindings-bind" "$COMMAND_KEYBINDINGS_PICKER"
bind_tmux_key_if_set "telescope-builtin-bind" "$COMMAND_BUILTIN_PICKER"
bind_tmux_key_if_set "telescope-directory-refresh-bind" "$COMMAND_REFRESH"
bind_tmux_key_if_set "telescope-rebuild-cache" "$COMMAND_REBUILD_CACHE"

if ! tmux show-option -g | grep -q "^@telescope-enable-preview"; then
    tmux set-option -g @telescope-enable-preview 1
fi

