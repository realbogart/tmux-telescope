# Changelog

## 0.1.2 - 2024-02-20

* [fix] Change all shebangs to #!/usr/bin/env bash

## [0.1.1] - 2024-01-30

* [feature] Zoxide support for Directory Sessions Picker.
* [fix] Directory Session Picker can handle dots (.) in paths.
* [fix] Zoxide setting preview option.

## [0.1.0] - 2024-01-29

* [feature] Option @telescope-enable-preview to enable/disable preview. Enabled by default.
* [feature] Possible to omit picker methods `picker_init` and/or `picker_preview`.
* [feature] Add Sessions Picker.
* [feature] Add Keybindings Picker.
* [feature] Add Builtin Picker.
* [feature] Add Panes Picker.
* [feature] Make picker_select function optional.
* [feature] Add label to picker windows.
* [fix] Not being able to switch to session names containing special characters.
* [fix] Tidy up `init.tmux`
* [fix] Remove redundant checks in picker_select functions.

