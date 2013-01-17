export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="jreese"
plugins=(rails git ruby textmate)
source $ZSH/oh-my-zsh.sh
unsetopt correct_all

# some utf-8 support
export locale=en_US.UTF-8
alias ls='ls -w'
alias ll='ls -lw'         # standard vertical listing
alias la='ls -Alw'        # show hidden files

# point java_home to system java
# export JAVA_HOME=$(/usr/libexec/java_home)

# aliases
alias -g be='bundle exec'
alias -g sudo='nocorrect sudo'

# $1 search
# $2 replace
prjreplace() {
  ack -l "$1" | xargs perl -pi -E "s/$1/$2/g"
}

bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word
bindkey '^[[5D' beginning-of-line
bindkey '^[[5C' end-of-line

source ~/.paths

# Aliases
source ~/.localrc
