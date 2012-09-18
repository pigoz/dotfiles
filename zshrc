export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="jreese"
plugins=(rails git ruby textmate)
source $ZSH/oh-my-zsh.sh

# point java_home to system java
export JAVA_HOME=$(/usr/libexec/java_home)

# aliases
alias -g be='bundle exec'
alias -g sudo='nocorrect sudo'


bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word
bindkey '^[[5D' beginning-of-line
bindkey '^[[5C' end-of-line

source ~/.paths

# Aliases
source ~/.localrc
