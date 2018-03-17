# stop default ^S
stty stop undef
# history navigation
bindkey '^R' history-incremental-search-backward
bindkey '^[[1;5C' forward-word                        # [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5D' backward-word                       # [Ctrl-LeftArrow] - move backward one word
bindkey '^[[3~' delete-char                           # delete
bindkey '^[3;5~' delete-char                          # delete
bindkey '\e[3~' delete-char                           # delete
autoload -U select-word-style
select-word-style bash
