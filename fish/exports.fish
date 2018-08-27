# set editor and pager
set -g -x LESS '--ignore-case --raw-control-chars'
set -g -x PAGER 'less'
set -g -x VISUAL vim
set -g -x EDITOR vim

# CTAGS Sorting in VIM/Emacs is better behaved with this in place
set -g -x LC_COLLATE C
set -g -x LC_ALL en_US.UTF-8
set -g -x LANG en_US.UTF-8

# Go environment
set -g -x GOPATH $HOME/go
set -g -x GOCACHE 'off'
set -g -x GOBIN $GOPATH/bin

set -g -x PATH $GOPATH/bin $PATH

#MAINFLUX ENV
set -g -x MF_HTTP_ADAPTER_PORT '8000'
set -g -x MF_NORMALIZER_PORT '8089'
set -g -x MF_USERS_HTTP_PORT '8180'
set -g -x MF_USERS_GRPC_PORT '8181'
set -g -x MF_THINGS_HTTP_PORT '8182'
set -g -x MF_THINGS_GRPC_PORT '8183'
set -g -x MF_INFLUX_WRITER_PORT '8900'
set -g -x MF_THINGS_URL 'localhost:8183'
set -g -x MF_THINGS_SECRET 'maneger'
set -g -x MF_USERS_URL 'localhost:8181'
set -g -x MF_USERS_SECRET 'manager'
set -g -x MF_MONGO_WRITER_PORT '8555'
