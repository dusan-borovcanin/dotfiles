# set editor and pager
export LESS='--ignore-case --raw-control-chars'
export PAGER='less'
export EDITOR=$VISUAL
export GIT_EDITOR=nvim
export EDITOR=vim
export VISUAL=nvim

export TERM=st-256color
export MANPAGER="nvim +Man!"

# dir stack size
export DIRSTACKSIZE=7

# CTAGS Sorting in VIM/Emacs is better behaved with this in place
export LC_COLLATE=C
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Go environment
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin

# ZSH config
export DOTFILES=$HOME/dotfiles

export PATH=/usr/local/bin:/usr/local/sbin:$GOPATH/bin:$PATH
export PATH=$PATH:/usr/local/go/bin

# Add Emacs tools
export PATH=$HOME/.config/emacs/bin:$PATH
