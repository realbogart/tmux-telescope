# tmux-telescope

## Description and Acknowledgements

This is a *fuzzy finder* tool for [tmux](https://github.com/tmux/tmux), installed using [tpm](https://github.com/tmux-plugins/tpm), inspired by [nvim-telescope](https://github.com/nvim-telescope/telescope.nvim) and powered by [fzf](https://github.com/junegunn/fzf). A big thank you to the authors of these amazing tools.

Note: Early in development, and supports only one *picker* so far!

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
set -g @telescope-directory-sessions-bind s     # Bind '<leader>s' to open Directory Sessions Picker described below.
set -g @telescope-directory-refresh-bind u      # Bind '<leader>u' to refresh Directory Sessions list.
```

## Features

### Directory Sessions Picker

The one and only *picker* so far. By default it's a list of local [Git](https://git-scm.com/) repositories found recursively from your home (`~`) directory. The search paths can be configured in the file `~/.tmux/plugins/tmux-telescope/userdata/gitroots`. You can provide a list of custom directories to add in `~/.tmux/plugins/tmux-telescope/userdata/custom-directories`.

When you pick an entry, a tmux session will be created and a terminal opened at the directory location. If the session already exists it will simply switch to it. Easy peasy.

The directory list is manually refreshed using the key binding `@telescope-directory-refresh-bind`. This is to avoid to unnecessary indexing and makes the *picker* open instantly.

# License

[MIT](LICENSE.md)

