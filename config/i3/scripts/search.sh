#!/bin/sh	

# q=$(echo "" | dmenu -fn 'DejaVu Sans Mono Nerd Font:size=16' -nb '#282A2E' -sb '#282A2E' -i -p "Search web:")
# q=$(rofi -dmenu)
# dotfiles_search "$q"

dotfiles_search $(rofi -dmenu -p "Search: " -theme-str '
  #inputbar {
    children: [prompt, entry];
    padding: 5px;
  }
  #prompt {
    padding: 5px 10px;
    font-weight: bold;
  }
  #entry {
    padding: 5px 10px;
    font-family: "Hack";
  }
  #listview {
    enabled: false;
  }
  #window {
    location: north;
    y-offset: 150;
    width: 600;
    border: 3px solid;
  }'
)