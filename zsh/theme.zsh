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

VIRTUAL_ENV_DISABLE_PROMPT=true

# Get the status of the working tree
function git_prompt_status() {
  local INDEX STATUS
  INDEX=$(command git status --porcelain -b 2> /dev/null)
  STATUS=""
  if $(echo "$INDEX" | command grep -E '^\?\? ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_UNTRACKED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^A  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_ADDED$STATUS"
  elif $(echo "$INDEX" | grep '^M  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_ADDED$STATUS"
  elif $(echo "$INDEX" | grep '^MM ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_ADDED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^ M ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  elif $(echo "$INDEX" | grep '^AM ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  elif $(echo "$INDEX" | grep '^MM ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  elif $(echo "$INDEX" | grep '^ T ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^R  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_RENAMED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^ D ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
  elif $(echo "$INDEX" | grep '^D  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
  elif $(echo "$INDEX" | grep '^AD ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
  fi
  if $(command git rev-parse --verify refs/stash >/dev/null 2>&1); then
    STATUS="$ZSH_THEME_GIT_PROMPT_STASHED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^UU ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_UNMERGED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^## [^ ]\+ .*ahead' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_AHEAD$STATUS"
  fi
  if $(echo "$INDEX" | grep '^## [^ ]\+ .*behind' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_BEHIND$STATUS"
  fi
  if $(echo "$INDEX" | grep '^## [^ ]\+ .*diverged' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DIVERGED$STATUS"
  fi
  echo $STATUS
}

# Outputs current branch info in prompt format
function git_prompt_info() {
  local ref
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

# Checks if working tree is dirty
function parse_git_dirty() {
  local STATUS=''
  local -a FLAGS
  FLAGS=('--porcelain')
  if [[ $POST_1_7_2_GIT -gt 0 ]]; then
    FLAGS+='--ignore-submodules=dirty'
  fi
  if [[ "$DISABLE_UNTRACKED_FILES_DIRTY" == "true" ]]; then
    FLAGS+='--untracked-files=no'
  fi
  STATUS=$(command git status ${FLAGS} 2> /dev/null | tail -n1)
  if [[ -n $STATUS ]]; then
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

# Define order and content of prompt
if [ ! -n "${BULLETTRAIN_PROMPT_ORDER+1}" ]; then
  BULLETTRAIN_PROMPT_ORDER=(
    time
    status
    dir
    screen
    virtualenv
    go
    elixir
    git
    cmd_exec_time
  )
fi

# PROMPT
if [ ! -n "${BULLETTRAIN_PROMPT_CHAR+1}" ]; then
  BULLETTRAIN_PROMPT_CHAR="\$"
fi
if [ ! -n "${BULLETTRAIN_PROMPT_ROOT+1}" ]; then
  BULLETTRAIN_PROMPT_ROOT=true
fi
if [ ! -n "${BULLETTRAIN_PROMPT_SEPARATE_LINE+1}" ]; then
  BULLETTRAIN_PROMPT_SEPARATE_LINE=true
fi
if [ ! -n "${BULLETTRAIN_PROMPT_ADD_NEWLINE+1}" ]; then
  BULLETTRAIN_PROMPT_ADD_NEWLINE=true
fi

# STATUS
if [ ! -n "${BULLETTRAIN_STATUS_EXIT_SHOW+1}" ]; then
  BULLETTRAIN_STATUS_EXIT_SHOW=false
fi
if [ ! -n "${BULLETTRAIN_STATUS_BG+1}" ]; then
  BULLETTRAIN_STATUS_BG=green
fi
if [ ! -n "${BULLETTRAIN_STATUS_ERROR_BG+1}" ]; then
  BULLETTRAIN_STATUS_ERROR_BG=red
fi
if [ ! -n "${BULLETTRAIN_STATUS_FG+1}" ]; then
  BULLETTRAIN_STATUS_FG=white
fi

# TIME
if [ ! -n "${BULLETTRAIN_TIME_BG+1}" ]; then
  BULLETTRAIN_TIME_BG=white
fi
if [ ! -n "${BULLETTRAIN_TIME_FG+1}" ]; then
  BULLETTRAIN_TIME_FG=black
fi

# VIRTUALENV
if [ ! -n "${BULLETTRAIN_VIRTUALENV_BG+1}" ]; then
  BULLETTRAIN_VIRTUALENV_BG=yellow
fi
if [ ! -n "${BULLETTRAIN_VIRTUALENV_FG+1}" ]; then
  BULLETTRAIN_VIRTUALENV_FG=white
fi
if [ ! -n "${BULLETTRAIN_VIRTUALENV_PREFIX+1}" ]; then
  BULLETTRAIN_VIRTUALENV_PREFIX=🐍
fi

# Go
if [ ! -n "${BULLETTRAIN_GO_BG+1}" ]; then
  BULLETTRAIN_GO_BG=cyan
fi
if [ ! -n "${BULLETTRAIN_GO_FG+1}" ]; then
  BULLETTRAIN_GO_FG=white
fi
if [ ! -n "${BULLETTRAIN_GO_PREFIX+1}" ]; then
  BULLETTRAIN_GO_PREFIX="go"
fi

# Kubernetes Context
if [ ! -n "${BULLETTRAIN_KCTX_BG+1}" ]; then
  BULLETTRAIN_KCTX_BG=yellow
fi
if [ ! -n "${BULLETTRAIN_KCTX_FG+1}" ]; then
  BULLETTRAIN_KCTX_FG=white
fi
if [ ! -n "${BULLETTRAIN_KCTX_PREFIX+1}" ]; then
  BULLETTRAIN_KCTX_PREFIX="⎈"
fi

# ELIXIR
if [ ! -n "${BULLETTRAIN_ELIXIR_BG+1}" ]; then
  BULLETTRAIN_ELIXIR_BG=magenta
fi
if [ ! -n "${BULLETTRAIN_ELIXIR_FG+1}" ]; then
  BULLETTRAIN_ELIXIR_FG=white
fi
if [ ! -n "${BULLETTRAIN_ELIXIR_PREFIX+1}" ]; then
  BULLETTRAIN_ELIXIR_PREFIX="💧"
fi

# DIR
if [ ! -n "${BULLETTRAIN_DIR_BG+1}" ]; then
  BULLETTRAIN_DIR_BG=blue
fi
if [ ! -n "${BULLETTRAIN_DIR_FG+1}" ]; then
  BULLETTRAIN_DIR_FG=white
fi
if [ ! -n "${BULLETTRAIN_DIR_CONTEXT_SHOW+1}" ]; then
  BULLETTRAIN_DIR_CONTEXT_SHOW=false
fi
if [ ! -n "${BULLETTRAIN_DIR_EXTENDED+1}" ]; then
  BULLETTRAIN_DIR_EXTENDED=1
fi

# GIT
if [ ! -n "${BULLETTRAIN_GIT_COLORIZE_DIRTY+1}" ]; then
  BULLETTRAIN_GIT_COLORIZE_DIRTY=false
fi
if [ ! -n "${BULLETTRAIN_GIT_COLORIZE_DIRTY_FG_COLOR+1}" ]; then
  BULLETTRAIN_GIT_COLORIZE_DIRTY_FG_COLOR=black
fi
if [ ! -n "${BULLETTRAIN_GIT_COLORIZE_DIRTY_BG_COLOR+1}" ]; then
  BULLETTRAIN_GIT_COLORIZE_DIRTY_BG_COLOR=yellow
fi
if [ ! -n "${BULLETTRAIN_GIT_BG+1}" ]; then
  BULLETTRAIN_GIT_BG=white
fi
if [ ! -n "${BULLETTRAIN_GIT_FG+1}" ]; then
  BULLETTRAIN_GIT_FG=black
fi
if [ ! -n "${BULLETTRAIN_GIT_EXTENDED+1}" ]; then
  BULLETTRAIN_GIT_EXTENDED=true
fi
if [ ! -n "${BULLETTRAIN_GIT_PROMPT_CMD+1}" ]; then
  BULLETTRAIN_GIT_PROMPT_CMD="\$(git_prompt_info)"
fi

# CONTEXT
if [ ! -n "${BULLETTRAIN_CONTEXT_BG+1}" ]; then
  BULLETTRAIN_CONTEXT_BG=black
fi
if [ ! -n "${BULLETTRAIN_CONTEXT_FG+1}" ]; then
  BULLETTRAIN_CONTEXT_FG=default
fi
if [ ! -n "${BULLETTRAIN_CONTEXT_HOSTNAME+1}" ]; then
  BULLETTRAIN_CONTEXT_HOSTNAME=%m
fi

# GIT PROMPT
if [ ! -n "${BULLETTRAIN_GIT_PREFIX+1}" ]; then
  ZSH_THEME_GIT_PROMPT_PREFIX="\ue0a0 "
else
  ZSH_THEME_GIT_PROMPT_PREFIX=$BULLETTRAIN_GIT_PREFIX
fi
if [ ! -n "${BULLETTRAIN_GIT_SUFFIX+1}" ]; then
  ZSH_THEME_GIT_PROMPT_SUFFIX=""
else
  ZSH_THEME_GIT_PROMPT_SUFFIX=$BULLETTRAIN_GIT_SUFFIX
fi
if [ ! -n "${BULLETTRAIN_GIT_DIRTY+1}" ]; then
  ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}✘%F{black}"
else
  ZSH_THEME_GIT_PROMPT_DIRTY=$BULLETTRAIN_GIT_DIRTY
fi
if [ ! -n "${BULLETTRAIN_GIT_CLEAN+1}" ]; then
  ZSH_THEME_GIT_PROMPT_CLEAN=" %F{green}✔%F{black}"
else
  ZSH_THEME_GIT_PROMPT_CLEAN=$BULLETTRAIN_GIT_CLEAN
fi
if [ ! -n "${BULLETTRAIN_GIT_ADDED+1}" ]; then
  ZSH_THEME_GIT_PROMPT_ADDED=" %F{green}✚%F{black}"
else
  ZSH_THEME_GIT_PROMPT_ADDED=$BULLETTRAIN_GIT_ADDED
fi
if [ ! -n "${BULLETTRAIN_GIT_MODIFIED+1}" ]; then
  ZSH_THEME_GIT_PROMPT_MODIFIED=" %F{blue}✹%F{black}"
else
  ZSH_THEME_GIT_PROMPT_MODIFIED=$BULLETTRAIN_GIT_MODIFIED
fi
if [ ! -n "${BULLETTRAIN_GIT_DELETED+1}" ]; then
  ZSH_THEME_GIT_PROMPT_DELETED=" %F{red}✖%F{black}"
else
  ZSH_THEME_GIT_PROMPT_DELETED=$BULLETTRAIN_GIT_DELETED
fi
if [ ! -n "${BULLETTRAIN_GIT_UNTRACKED+1}" ]; then
  ZSH_THEME_GIT_PROMPT_UNTRACKED=" %F{yellow}✭%F{black}"
else
  ZSH_THEME_GIT_PROMPT_UNTRACKED=$BULLETTRAIN_GIT_UNTRACKED
fi
if [ ! -n "${BULLETTRAIN_GIT_RENAMED+1}" ]; then
  ZSH_THEME_GIT_PROMPT_RENAMED=" ➜"
else
  ZSH_THEME_GIT_PROMPT_RENAMED=$BULLETTRAIN_GIT_RENAMED
fi
if [ ! -n "${BULLETTRAIN_GIT_UNMERGED+1}" ]; then
  ZSH_THEME_GIT_PROMPT_UNMERGED=" ═"
else
  ZSH_THEME_GIT_PROMPT_UNMERGED=$BULLETTRAIN_GIT_UNMERGED
fi
if [ ! -n "${BULLETTRAIN_GIT_AHEAD+1}" ]; then
  ZSH_THEME_GIT_PROMPT_AHEAD=" ⬆"
else
  ZSH_THEME_GIT_PROMPT_AHEAD=$BULLETTRAIN_GIT_AHEAD
fi
if [ ! -n "${BULLETTRAIN_GIT_BEHIND+1}" ]; then
  ZSH_THEME_GIT_PROMPT_BEHIND=" ⬇"
else
  ZSH_THEME_GIT_PROMPT_BEHIND=$BULLETTRAIN_GIT_BEHIND
fi
if [ ! -n "${BULLETTRAIN_GIT_DIVERGED+1}" ]; then
  ZSH_THEME_GIT_PROMPT_DIVERGED=" ⬍"
else
  ZSH_THEME_GIT_PROMPT_DIVERGED=$BULLETTRAIN_GIT_PROMPT_DIVERGED
fi

# SCREEN
if [ ! -n "${BULLETTRAIN_SCREEN_BG+1}" ]; then
  BULLETTRAIN_SCREEN_BG=white
fi
if [ ! -n "${BULLETTRAIN_SCREEN_FG+1}" ]; then
  BULLETTRAIN_SCREEN_FG=black
fi
if [ ! -n "${BULLETTRAIN_SCREEN_PREFIX+1}" ]; then
  BULLETTRAIN_SCREEN_PREFIX="⬗"
fi

# COMMAND EXECUTION TIME
if [ ! -n "${BULLETTRAIN_EXEC_TIME_ELAPSED+1}" ]; then
  BULLETTRAIN_EXEC_TIME_ELAPSED=5
fi
if [ ! -n "${BULLETTRAIN_EXEC_TIME_BG+1}" ]; then
  BULLETTRAIN_EXEC_TIME_BG=yellow
fi
if [ ! -n "${BULLETTRAIN_EXEC_TIME_FG+1}" ]; then
  BULLETTRAIN_EXEC_TIME_FG=black
fi


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
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

# ------------------------------------------------------------------------------
# PROMPT COMPONENTS
# Each component will draw itself, and hide itself if no information needs
# to be shown
# ------------------------------------------------------------------------------

# Context: user@hostname (who am I and where am I)
context() {
  local user="$(whoami)"
  [[ "$user" != "$BULLETTRAIN_CONTEXT_DEFAULT_USER" || -n "$BULLETTRAIN_IS_SSH_CLIENT" ]] && echo -n "${user}@$BULLETTRAIN_CONTEXT_HOSTNAME"
}

prompt_context() {
  local _context="$(context)"
  [[ -n "$_context" ]] && prompt_segment $BULLETTRAIN_CONTEXT_BG $BULLETTRAIN_CONTEXT_FG "$_context"
}

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
  if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" == "1" ]]; then
    return
  fi

  local ref dirty mode repo_path git_prompt
  repo_path=$(git rev-parse --git-dir 2>/dev/null)

  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    if [[ $BULLETTRAIN_GIT_COLORIZE_DIRTY == true && -n $(git status --porcelain --ignore-submodules) ]]; then
      BULLETTRAIN_GIT_BG=$BULLETTRAIN_GIT_COLORIZE_DIRTY_BG_COLOR
      BULLETTRAIN_GIT_FG=$BULLETTRAIN_GIT_COLORIZE_DIRTY_FG_COLOR
    fi
    prompt_segment $BULLETTRAIN_GIT_BG $BULLETTRAIN_GIT_FG

    eval git_prompt=${BULLETTRAIN_GIT_PROMPT_CMD}
    if [[ $BULLETTRAIN_GIT_EXTENDED == true ]]; then
      echo -n ${git_prompt}$(git_prompt_status)
    else
      echo -n ${git_prompt}
    fi
  fi
}

# Dir: current working directory
prompt_dir() {
  local dir=''
  local _context="$(context)"
  [[ $BULLETTRAIN_DIR_CONTEXT_SHOW == true && -n "$_context" ]] && dir="${dir}${_context}:"

  if [[ $BULLETTRAIN_DIR_EXTENDED == 0 ]]; then
    #short directories
    dir="${dir}%1~"
  elif [[ $BULLETTRAIN_DIR_EXTENDED == 2 ]]; then
    #long directories
    dir="${dir}%0~"
  else
    #medium directories (default case)
    dir="${dir}%4(c:...:)%3c"
  fi

  prompt_segment $BULLETTRAIN_DIR_BG $BULLETTRAIN_DIR_FG $dir
}

# ELIXIR
prompt_elixir() {
  if command -v elixir > /dev/null 2>&1; then
    prompt_segment $BULLETTRAIN_ELIXIR_BG $BULLETTRAIN_ELIXIR_FG $BULLETTRAIN_ELIXIR_PREFIX" $(elixir -v | tail -n 1 | awk '{print $2}')"
  fi
}

# Go
prompt_go() {
  setopt extended_glob
  if [[ (-f *.go(#qN) || -d Godeps || -f glide.yaml) ]]; then
    if command -v go > /dev/null 2>&1; then
      prompt_segment $BULLETTRAIN_GO_BG $BULLETTRAIN_GO_FG $BULLETTRAIN_GO_PREFIX" $(go version | grep --colour=never -oE '[[:digit:]].[[:digit:]]+')"
    fi
  fi
}

# Kubernetes Context
prompt_kctx() {
  if [[ ! -n $BULLETTRAIN_KCTX_KCONFIG ]]; then
    return
  fi
  if command -v kubectl > /dev/null 2>&1; then
    if [[ -f $BULLETTRAIN_KCTX_KCONFIG ]]; then
      prompt_segment $BULLETTRAIN_KCTX_BG $BULLETTRAIN_KCTX_FG $BULLETTRAIN_KCTX_PREFIX" $(cat $BULLETTRAIN_KCTX_KCONFIG|grep current-context| awk '{print $2}')"
    fi
  fi
}

# Virtualenv: current working virtualenv
prompt_virtualenv() {
  local virtualenv_path="$VIRTUAL_ENV"
  if [[ -n $virtualenv_path && -n $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
    prompt_segment $BULLETTRAIN_VIRTUALENV_BG $BULLETTRAIN_VIRTUALENV_FG $BULLETTRAIN_VIRTUALENV_PREFIX" $(basename $virtualenv_path)"
  elif which pyenv &> /dev/null; then
    prompt_segment $BULLETTRAIN_VIRTUALENV_BG $BULLETTRAIN_VIRTUALENV_FG $BULLETTRAIN_VIRTUALENV_PREFIX" $(pyenv version | sed -e 's/ (set.*$//' | tr '\n' ' ' | sed 's/.$//')"
  fi
}

# SCREEN Session
prompt_screen() {
  local session_name="$STY"
  if [[ "$session_name" != "" ]]; then
    prompt_segment $BULLETTRAIN_SCREEN_BG $BULLETTRAIN_SCREEN_FG $BULLETTRAIN_SCREEN_PREFIX" $session_name"
  fi
}

prompt_time() {
  if [[ $BULLETTRAIN_TIME_12HR == true ]]; then
    prompt_segment $BULLETTRAIN_TIME_BG $BULLETTRAIN_TIME_FG %D{%r}
  else
    prompt_segment $BULLETTRAIN_TIME_BG $BULLETTRAIN_TIME_FG %D{%T}
  fi
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local symbols
  symbols=()
  [[ $RETVAL -ne 0 && $BULLETTRAIN_STATUS_EXIT_SHOW != true ]] && symbols+="✘"
  [[ $RETVAL -ne 0 && $BULLETTRAIN_STATUS_EXIT_SHOW == true ]] && symbols+="✘ $RETVAL"
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}⚡%f"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="⚙"

  if [[ -n "$symbols" && $RETVAL -ne 0 ]]; then
    prompt_segment $BULLETTRAIN_STATUS_ERROR_BG $BULLETTRAIN_STATUS_FG "$symbols"
  elif [[ -n "$symbols" ]]; then
    prompt_segment $BULLETTRAIN_STATUS_BG $BULLETTRAIN_STATUS_FG "$symbols"
  fi

}

# Prompt Character
prompt_chars() {
  local bt_prompt_chars="${BULLETTRAIN_PROMPT_CHAR}"

  if [[ $BULLETTRAIN_PROMPT_ROOT == true ]]; then
    bt_prompt_chars="%(!.%F{red}# .%F{green}${bt_prompt_chars}%f)"
  fi

  if [[ $BULLETTRAIN_PROMPT_SEPARATE_LINE == false ]]; then
    bt_prompt_chars="${bt_prompt_chars}"
  fi

  echo -n "$bt_prompt_chars"

  if [[ -n $BULLETTRAIN_PROMPT_CHAR ]]; then
    echo -n " "
  fi
}

# Prompt Line Separator
prompt_line_sep() {
  if [[ $BULLETTRAIN_PROMPT_SEPARATE_LINE == true ]]; then
    # newline wont print without a non newline character, so add a zero-width space
    echo -e '\n%{\u200B%}'
  fi
}

# ------------------------------------------------------------------------------
# MAIN
# Entry point
# ------------------------------------------------------------------------------

build_prompt() {
  RETVAL=$?
  for segment in $BULLETTRAIN_PROMPT_ORDER
  do
    prompt_$segment
  done
  prompt_end
}

NEWLINE='
'
PROMPT=''
[[ $BULLETTRAIN_PROMPT_ADD_NEWLINE == true ]] && PROMPT="$PROMPT$NEWLINE"
PROMPT="$PROMPT"'%{%f%b%k%}$(build_prompt)'
[[ $BULLETTRAIN_PROMPT_SEPARATE_LINE == true ]] && PROMPT="$PROMPT$NEWLINE"
PROMPT="$PROMPT"'%{${fg_bold[default]}%}'
[[ $BULLETTRAIN_PROMPT_SEPARATE_LINE == false ]] && PROMPT="$PROMPT "
PROMPT="$PROMPT"'$(prompt_chars)%{$reset_color%}'
