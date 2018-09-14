# set editor and pager
export LESS='--ignore-case --raw-control-chars'
export PAGER='less'
export VISUAL=vim
export EDITOR=vim

# dir stack size
export DIRSTACKSIZE=7

# CTAGS Sorting in VIM/Emacs is better behaved with this in place
export LC_COLLATE=C
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Go environment
export GOPATH=$HOME/go
export GOCACHE='off'
export GOBIN=$GOPATH/bin

#ZSH config
export ZSH_CUSTOM=$HOME/dotfiles

# Color setup
export TERM='xterm-256color'

# libraries
if [[ $(uname) = 'Linux' ]]; then
    export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
fi
export PATH=/usr/local/bin:/usr/local/sbin:$GOPATH/bin:$PATH

#MAINFLUX ENV
export MF_HTTP_ADAPTER_PORT='8000'
export MF_NORMALIZER_PORT='8089'
export MF_USERS_HTTP_PORT='8180'
export MF_USERS_GRPC_PORT='8181'
export MF_THINGS_HTTP_PORT='8182'
export MF_THINGS_GRPC_PORT='8183'
export MF_INFLUX_WRITER_PORT='8900'
export MF_THINGS_URL='localhost:8183'
export MF_THINGS_SECRET='maneger'
export MF_USERS_URL='localhost:8181'
export MF_USERS_SECRET='manager'
export MF_MONGO_WRITER_PORT='8555'

#MONETASA ENV
export MONETASA_AUTH_URL='localhost:8081'
export MONETASA_TRANSACTIONS_HTTP_PORT='8082'
export MONETASA_TRANSACTIONS_GRPC_PORT='8083'
export MONETASA_STREAMS_HTTP_PORT='8084'
export MONETASA_STREAMS_GRPC_PORT='8085'
export MONETASA_SUBSCRIPTIONS_PORT='8086'
export MONETASA_STREAMS_URL='localhost:8085'
export MONETASA_TRANSACTIONS_URL='localhost:8083'
