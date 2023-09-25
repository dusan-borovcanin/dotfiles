#!/bin/bash
echo "Find in $(pwd)"
read -p ">" input
res=$(rg --files-with-matches --no-messages "$input" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$input' || rg --ignore-case --pretty --context 10 '$input' {}")
if [[ ! -z "$res" ]];
    then $EDITOR "$res"
    exit
fi
