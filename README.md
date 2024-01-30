# tmux-telescope

## Description and Acknowledgements

This is a *fuzzy finder* tool for [tmux](https://github.com/tmux/tmux), installed using [tpm](https://github.com/tmux-plugins/tpm), inspired by [nvim-telescope](https://github.com/nvim-telescope/telescope.nvim) and powered by [fzf](https://github.com/junegunn/fzf). A big thank you to the authors of these amazing tools.

Note: Early in development, and supports only a few *pickers* so far.

## Requirements

* [fzf](https://github.com/junegunn/fzf) needs to be installed and in your `$PATH`. Installation instructions [here](https://github.com/junegunn/fzf?tab=readme-ov-file#installation).

## Installation

Install using [tpm](https://github.com/tmux-plugins/tpm) by adding the following to your `tmux.conf`:

```bash
set -g @plugin 'realbogart/tmux-telescope'
```

And then hit `<leader> + I`. The *plugin* doesn't set up any keybindings by default, so here is an example configuration:

```bash
bind S choose-session                           # Re-bind default session choser to '<leader>S'.
set -g @telescope-directory-sessions-bind j     # Bind '<leader>j' to open Directory Sessions Picker.
set -g @telescope-sessions-bind s               # Bind '<leader>s' to open Sessions Picker.
set -g @telescope-panes-bind a                  # Bind '<leader>a' to open Panes Picker.
set -g @telescope-keybindings-bind k            # Bind '<leader>k' to open Keybindings Picker.
set -g @telescope-builtin-bind b                # Bind '<leader>b' to open Builtin Picker.
set -g @telescope-rebuild-cache u               # Bind '<leader>u' to refresh Directory Sessions list.
```

## Features

### Builtin Picker

A good way to explore the features of `tmux-telescope`. It simply lists all of the pickers and when you pick one, it opens.

### Directory Sessions Picker

By default it will list [Git](https://git-scm.com/) repositories found recursively from your home (`~`) directory. The search paths can be configured in the file `~/.tmux/plugins/tmux-telescope/userdata/gitroots`. You can provide a list of custom directories to add in `~/.tmux/plugins/tmux-telescope/userdata/custom-directories`.

When you pick an entry, a tmux session will be created and a terminal opened at the directory location. If the session already exists it will simply switch to it. Easy peasy.

The directory list is manually refreshed using the key binding `@telescope-rebuild-cache`. This is to avoid to unnecessary indexing and makes the *picker* open instantly.

### Sessions Picker

List open sessions. Picking one switches to that session.

### Keybindings Picker

List tmux category keybindings. No action when picking one.

### Panes Picker

List all panes and their current command. For instance, you can filter for `nvim` to find all instances of [neovim](https://neovim.io/). When you pick one, you go to that pane.

## Options

```bash
set -g @telescope-enable-preview 0  # Disable preview on pickers. It's enabled (1) by default.
set -g @telescope-enable-zoxide 1  # Enable Zoxide for Directory Sessions Picker. It's disabled (0) by default.
```
## Changelog

The changelog can be read [here](CHANGELOG.md).

## License

[MIT](LICENSE.md)

