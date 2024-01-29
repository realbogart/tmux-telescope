#!/bin/bash

picker_list() {
    tmux list-panes -a -F "#{session_name}:#{window_index}.#{pane_index} #{pane_current_command}"
}

picker_preview() {
    pane_info=$(echo "$1" | awk '{print $1}')
    session_name="${pane_info%%:*}"
    window_and_pane="${pane_info#*:}"
    window="${window_and_pane%.*}"
    pane="${window_and_pane#*.}"

    preview_pane "$session_name" "$window" "$pane"
}

picker_select() {
    pane_info=$(echo "$1" | head -n 1 | cut -d ' ' -f 1)
    if [ -n "$pane_info" ]; then
        tmux switch-client -t "${pane_info%.*}"
        tmux select-window -t "${pane_info%.*}"
        tmux select-pane -t "$pane_info"
    fi
}

