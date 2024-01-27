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
bind S choose-session                   # Re-bind default session choser to '<leader>S'.
set -g @telescope-git-sessions-bind s   # Bind '<leader>s' to open Git Sessions Picker described below.
set -g @telescope-git-refresh-bind u    # Bind '<leader>u' to refresh Git Sessions list.
```

## Features

### Git Sessions Picker

The one and only *picker* so far. It's a list of local [Git](https://git-scm.com/) repositories. By default it recursively finds all repositories under your home (`~`) directory, but the search paths can be configured in the file `~/.tmux/plugins/tmux-telescope/userdata/gitroots`.

When you pick an entry, a tmux session will be created and a terminal opened at the repository location. If the session already exists it will simply switch to it. Easy peasy.

The repository list is manually refreshed using the key binding `@telescope-git-refresh-bind`. This is to avoid to unnecessary indexing and makes the *picker* open instantly.

# License

[MIT](LICENSE.md)

