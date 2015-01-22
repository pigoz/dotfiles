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

# add cabal binaries
export PATH=~/.cabal/bin:$PATH

# add official llvm binaries installed through homebrew
export PATH=/usr/local/opt/llvm/bin:$PATH

# add path to the haxe standard library
export HAXE_STD_PATH="/usr/local/lib/haxe/std"

# Load rbenv
if command_exists rbenv ; then
  eval "$(rbenv init - zsh)"
else
  echo "failed to load rbenv"
fi
