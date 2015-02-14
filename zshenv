command_exists () {
  type "$1" &> /dev/null ;
}

if command_exists rbenv ; then
  export VISUAL="mvim --nofork"
fi

# nicer auto installer
export rvm_ignore_dotfiles=yes

# add rbenv shims to path
export PATH=$HOME/.rbenv/bin:$PATH

# nodejs paths
export PATH=/usr/local/share/npm/bin:$PATH

# add cabal binaries
export PATH=~/.cabal/bin:$PATH

# add official llvm binaries installed through homebrew
export PATH=/usr/local/opt/llvm/bin:$PATH

export PATH=/usr/local/sbin:$PATH

# add path to the haxe standard library
export HAXE_STD_PATH="/usr/local/lib/haxe/std"

PKG_CONFIG_PATH=/usr/local/opt/libass-ct/lib/pkgconfig:$PKG_CONFIG_PATH
PKG_CONFIG_PATH=$(python3-config --prefix)/lib/pkgconfig:$PKG_CONFIG_PATH
export PKG_CONFIG_PATH

# Load rbenv
if command_exists rbenv ; then
  eval "$(rbenv init - zsh)"
else
  echo "failed to load rbenv"
fi
