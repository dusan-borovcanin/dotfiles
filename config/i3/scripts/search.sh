#!/bin/sh

q=$(echo "" | dmenu -fn 'DejaVu Sans Mono Nerd Font:size=14' -nb '#004D40' -sb '#004D40' -i -p "Search web:")
dotfiles_search "$q"