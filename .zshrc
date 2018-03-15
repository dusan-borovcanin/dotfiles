export ZSH=/home/dusanb/.oh-my-zsh
source $ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

POWERLEVEL9K_MODE="nerdfont-complete"
ZSH_THEME="powerlevel9k/powerlevel9k"
plugins=(
  git,
  go,
  docker
)
source $ZSH/oh-my-zsh.sh

# SYNTAX HIGHLIGHT
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
ZSH_HIGHLIGHT_STYLES[cursor]='bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=blue'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=blue'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=blue'
ZSH_HIGHLIGHT_STYLES[function]='fg=blue'
ZSH_HIGHLIGHT_STYLES[command]='fg=blue'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=blue'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=blue'

# ALIASES
alias terminal="gnome-terminal"

# AUTOSUGGESTION
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=242"

#TEHEME
POWERLEVEL9K_VCS_GIT_GITHUB_ICON="\uf09b"
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=""
POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=""
POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND="clear"
POWERLEVEL9K_BATTERY_DISCONNECTED_FOREGROUND="blue"
POWERLEVEL9K_BATTERY_VERBOSE="false"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
POWERLEVEL9K_PROMPT_ON_NEWLINE="true"
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%K{blue}%F{black} \uf017 %* %f%k%F{blue}%f "
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(background_jobs)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(battery root_indicator dir vcs)
