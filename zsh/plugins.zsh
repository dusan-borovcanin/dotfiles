source $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source <(kubectl completion zsh)

#Autosuggestion color
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'
source ~/.fzf.zsh
#Theme settings
export BULLETTRAIN_GO_PREFIX='\ue626'
export BULLETTRAIN_GIT_COLORIZE_DIRTY=true
export BULLETTRAIN_TIME_BG='black'
export BULLETTRAIN_TIME_FG='white'
