#!/bin/bash

picker_rebuild_cache() {
    #
    # Custom directories
    #
    echo "Verifying and adding custom directories"

    if [ ! -f "$CUSTOM_DIRECTORIES_FILE" ]; then
        echo "Creating '$CUSTOM_DIRECTORIES_FILE' with default directory '~'"
        echo "~" > "$CUSTOM_DIRECTORIES_FILE"
    fi

    file_contents=$(cat "$CUSTOM_DIRECTORIES_FILE")
    eval_and_verify_directories "$file_contents"

    if [[ -n "$file_contents" ]]; then
        echo -e "$verified_dirs" > "$PICKER_CACHE"
    fi

    #
    # Git directories
    #
    if [ ! -f "$GITROOTS_FILE" ]; then
        echo "Creating '$GITROOTS_FILE' with default directory '~'"
        echo "~" > "$GITROOTS_FILE"
    fi

    file_contents=$(cat "$GITROOTS_FILE")
    eval_and_verify_directories "$file_contents"

    git_dirs=""
    while IFS= read -r dir; do
        echo "Finding Git repositories from '$dir'"

        if [[ -n "$git_dirs" ]]; then
            git_dirs+=$'\n'
        fi

        git_dirs+=$(find_git_dirs "$dir")
    done <<< "$verified_dirs"

    if [[ -n "$git_dirs" ]]; then
        echo "$git_dirs" >> "$PICKER_CACHE"
    fi
}

picker_list () {
    if tmux show-option -gqv "@telescope-enable-zoxide" | grep -q "1" && command -v zoxide >/dev/null 2>&1; then
        zoxide query -l | sed "s|^$HOME|~|g"
    fi

    cat "$PICKER_CACHE" | sed "s|^$HOME|~|g"
}

picker_preview () {
    preview_pane "$1"
}

picker_select () {
    selected_dir=$1
    selected_dir_expanded=$(echo "$1" | sed "s|^~|$HOME|g")

    session_name=$(echo "$selected_dir" | sed 's/\./_/g')
    session_name_escaped=$(printf '%q' "$session_name")

    if [ -z "$selected_dir" ]; then
        exit 0
    fi

    if tmux has-session -t "$session_name_escaped" 2>/dev/null; then
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

