export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="jreese"
plugins=(rails git ruby textmate)
source $ZSH/oh-my-zsh.sh

# point java_home to system java
export JAVA_HOME=$(/usr/libexec/java_home)

# ec2 configuration
export EC2_PRIVATE_KEY=$HOME/.ec2/pk-1.pem
export EC2_CERT=$HOME/.ec2/cert-1.pem
export EC2_HOME=$HOME/ec2-api-tools

# PATH Definition
PATH=/opt/X11/bin:/usr/X11/bin:$PATH
PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH
PATH=$HOME/.cabal/bin:$HOME/bin/:$HOME/Library/Haskell/bin:$PATH
export PATH=$EC2_HOME/bin:$PATH

bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word
bindkey '^[[5D' beginning-of-line
bindkey '^[[5C' end-of-line

# Aliases
source ~/.localrc

# Load RVM
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
