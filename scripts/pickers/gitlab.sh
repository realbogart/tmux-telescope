#!/bin/bash

picker_rebuild_cache() {
	# Set GITLAB_API_TOKEN to authenticate
	# https://docs.gitlab.com/ee/api/rest/#authentication
	if [[ -z "$GITLAB_API_TOKEN" ]]; then
		return
	fi

	# TODO: config var
	if [[ -z "$WORK_GITLAB" ]]; then
		return
	fi

	# Assumes jq is installed
	# TODO: pagination
	# TODO: limit to favorite subgroup
	# TODO: make WORK_GITLAB conf var
	projects=$(curl --request GET \
		--header "PRIVATE-TOKEN: $GITLAB_API_TOKEN" \
		"https://$WORK_GITLAB/api/v4/projects?per_page=100" |
		jq ".[] .path_with_namespace" |
		sed "s|\"||g")

	# TODO: fix cache
	if [[ -n "$projects" ]]; then
		echo "$projects" >"$PICKER_CACHE"
	fi
}

picker_list() {
	cat "$PICKER_CACHE"
}

picker_select() {
	selected=$1
	selected_expanded="git@$WORK_GITLAB/$selected"
	# TODO: target dir for cloning
	selected_dir="$HOME/$selected"

	session_name=$(echo "$selected" | sed 's/\./_/g')
	session_name_escaped=$(printf '%q' "$session_name")

	if [ -z "$selected_dir" ]; then
		exit 0
	fi

	if [ ! -d "$selected_dir" ]; then
		mkdir -p $selected_dir
		git clone git@$WORK_GITLAB:$selected.git $selected_dir
	fi

	if tmux has-session -t "$session_name_escaped" 2>/dev/null; then
		if [ -n "$TMUX" ]; then
			tmux switch-client -t "$session_name_escaped"
		else
			tmux attach-session -t "$session_name_escaped"
		fi
	else
		tmux new-session -d -s "$session_name" -c "$selected_dir"
		if [ -n "$TMUX" ]; then
			tmux switch-client -t "$session_name_escaped"
		else
			tmux attach-session -t "$session_name_escaped"
		fi
	fi
}
