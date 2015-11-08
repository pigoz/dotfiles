command_exists () {
  type "$1" &> /dev/null ;
}

if command_exists rbenv ; then
  export VISUAL="mvim --nofork"
fi

# add rbenv shims to path
export PATH=$HOME/.rbenv/bin:$PATH

# nodejs paths
export PATH=/usr/local/share/npm/bin:$PATH

# add cabal binaries
export PATH=~/.cabal/bin:$PATH

# mactex basic
export PATH=~/usr/local/texlive/2015basic/bin/x86_64-darwin:$PATH

# system bin
export PATH=/usr/local/sbin:$PATH

# Go stuff
export GOPATH=$HOME/dev/gocode
export PATH=$GOPATH/bin:$PATH

export PKG_CONFIG_PATH=$(python3-config --prefix)/lib/pkgconfig:$PKG_CONFIG_PATH

# Load rbenv
if command_exists rbenv ; then
  eval "$(rbenv init - zsh)"
else
  echo "failed to load rbenv"
fi
