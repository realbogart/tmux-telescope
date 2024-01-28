#!/bin/bash

picker_init () {
    :
}

picker_rebuild_cache() {
    > $PICKER_CACHE

    $SCRIPTS_DIR/add-custom-directories.sh
    $SCRIPTS_DIR/find-git-repositories.sh

    echo "Done!"
}

picker_list () {
    cat "$PICKER_CACHE" | sed "s|^$HOME|~|g"
}

picker_preview () {
    preview_session "$1"
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

