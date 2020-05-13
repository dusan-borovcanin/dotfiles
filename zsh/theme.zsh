# README
#
# In order for this theme to render correctly, you will need a
# [Powerline-patched font](https://github.com/Lokaltog/powerline-fonts).
#
# In addition, I recommend the
# [Tomorrow Night theme](https://github.com/chriskempson/tomorrow-theme) and, if
# you're using it on Mac OS X, [iTerm 2](http://www.iterm2.com/) over
# Terminal.app - it has significantly better color fidelity.

# ------------------------------------------------------------------------------
# CONFIGURATION
# The default configuration, that can be overwrite in your .zshrc file
# ------------------------------------------------------------------------------

# STATUS
BULLETTRAIN_STATUS_BG=green
BULLETTRAIN_STATUS_ERROR_BG=red
BULLETTRAIN_STATUS_FG=white

# TIME
BULLETTRAIN_TIME_BG=black
BULLETTRAIN_TIME_FG=white

# DIR
BULLETTRAIN_DIR_BG=green
BULLETTRAIN_DIR_FG=white

# GIT
BULLETTRAIN_GIT_COLORIZE_DIRTY=false
BULLETTRAIN_GIT_COLORIZE_DIRTY_FG_COLOR=black
BULLETTRAIN_GIT_COLORIZE_DIRTY_BG_COLOR=yellow
BULLETTRAIN_GIT_BG=white
BULLETTRAIN_GIT_FG=black
BULLETTRAIN_GIT_PROMPT_CMD="\$(git_prompt_info)"

# GIT PROMPT
ZSH_THEME_GIT_PROMPT_PREFIX="\ue0a0"
ZSH_THEME_GIT_PROMPT_DIRTY="%F{red}✘%F{black}"
ZSH_THEME_GIT_PROMPT_CLEAN="%F{green}✔%F{black}"

# COMMAND EXECUTION TIME
BULLETTRAIN_EXEC_TIME_ELAPSED=3
BULLETTRAIN_EXEC_TIME_BG=red
BULLETTRAIN_EXEC_TIME_FG=white


# ------------------------------------------------------------------------------
# SEGMENT DRAWING
# A few functions to make it easy and re-usable to draw segmented prompts
# ------------------------------------------------------------------------------

CURRENT_BG='NONE'
SEGMENT_SEPARATOR=''

# Begin a segment
# Takes three arguments, background, foreground and text. All of them can be omitted,
# rendering default background/foreground and no text.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n "%{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%}"
  else
    echo -n "%{$bg%}%{$fg%}"
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

# Outputs current branch info in prompt format
function git_prompt_info() {
  local ref
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)"
}

# Checks if working tree is dirty
function parse_git_dirty() {
  local STATUS=''
  local -a FLAGS
  FLAGS=('--porcelain')
  FLAGS+='--ignore-submodules=dirty'
  STATUS=$(command git status ${FLAGS} 2> /dev/null | tail -n1)
  if [[ -n $STATUS ]]; then
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

# ------------------------------------------------------------------------------
# PROMPT COMPONENTS
# Each component will draw itself, and hide itself if no information needs
# to be shown
# ------------------------------------------------------------------------------

# Based on http://stackoverflow.com/a/32164707/3859566
function displaytime {
  local T=$1
  local H=$((T/60/60%24))
  local M=$((T/60%60))
  local S=$((T%60))
  [[ $D > 0 ]] && printf '%dd' $D
  [[ $H > 0 ]] && printf '%dh' $H
  [[ $M > 0 ]] && printf '%dm' $M
  printf '%ds' $S
}

# Prompt previous command execution time
preexec() {
  cmd_timestamp=`date +%s`
}

precmd() {
  local stop=`date +%s`
  local start=${cmd_timestamp:-$stop}
  let BULLETTRAIN_last_exec_duration=$stop-$start
  cmd_timestamp=''
}

prompt_cmd_exec_time() {
  [ $BULLETTRAIN_last_exec_duration -gt $BULLETTRAIN_EXEC_TIME_ELAPSED ] && prompt_segment $BULLETTRAIN_EXEC_TIME_BG $BULLETTRAIN_EXEC_TIME_FG "$(displaytime $BULLETTRAIN_last_exec_duration)"
}

# Git
prompt_git() {
  local git_prompt
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    if [[ -n $(git status --porcelain --ignore-submodules) ]]; then
      BULLETTRAIN_GIT_BG=$BULLETTRAIN_GIT_COLORIZE_DIRTY_BG_COLOR
      BULLETTRAIN_GIT_FG=$BULLETTRAIN_GIT_COLORIZE_DIRTY_FG_COLOR
    fi
    prompt_segment $BULLETTRAIN_GIT_BG $BULLETTRAIN_GIT_FG

    eval git_prompt=${BULLETTRAIN_GIT_PROMPT_CMD}
    echo -n ${git_prompt}
  fi
}

# Dir: current working directory
prompt_dir() {
  local dir=''

  #medium directories (default case)
  dir="${dir}%4(c:...:)%3c"
  prompt_segment $BULLETTRAIN_DIR_BG $BULLETTRAIN_DIR_FG $dir
}

prompt_time() {
  prompt_segment $BULLETTRAIN_TIME_BG $BULLETTRAIN_TIME_FG %D{%T}
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local symbols
  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="✘"
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}⚡%f"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="⚙"

  if [[ -n "$symbols" && $RETVAL -ne 0 ]]; then
    prompt_segment $BULLETTRAIN_STATUS_ERROR_BG $BULLETTRAIN_STATUS_FG "$symbols"
  elif [[ -n "$symbols" ]]; then
    prompt_segment $BULLETTRAIN_STATUS_BG $BULLETTRAIN_STATUS_FG "$symbols"
  fi
}

# ------------------------------------------------------------------------------
# MAIN
# Entry point
# ------------------------------------------------------------------------------

build_prompt() {
  RETVAL=$?
  prompt_time
  prompt_status
  prompt_dir
  prompt_git
  prompt_cmd_exec_time
  prompt_end
}

NEWLINE='
'
PROMPT=''
PROMPT="$PROMPT"'%{%f%b%k%}$(build_prompt)'
PROMPT="$PROMPT$NEWLINE"
PROMPT="$PROMPT"'%{${green[default]}%}'
