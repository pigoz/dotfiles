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

# Load rbenv / rvm
if command_exists rbenv ; then
  eval "$(rbenv init - zsh)"
else
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
fi
