source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

source <(kubectl completion zsh)


# Use ripgrep combined with preview
# find-in-file - usage: fif <searchTerm>
fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  res=$(rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}")
  if [[ ! -z "$res" ]]; then vim "$res"; return 0; fi
}

__finder__() {
  exec st -c="fzf-menu" -e bash "/home/dusan/dotfiles/config/i3/scripts/finder.sh"
}

__fzf-finder-menu__() {
  LBUFFER="${LBUFFER}$(__finder__)"
  local ret=$?
  zle reset-prompt
  return $ret
}

zle     -N    __fzf-finder-menu__
bindkey -M emacs '^F' __fzf-finder-menu__
bindkey -M vicmd '^F' __fzf-finder-menu__
bindkey -M viins '^F' __fzf-finder-menu__

# Edit in $VISUAL
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line
