#!/bin/sh

q=$(echo "" | dmenu -fn 'DejaVu Sans Mono Nerd Font:size=15' -nb '#282A2E' -sb '#282A2E' -i -p "Search web:")
dotfiles_search "$q"