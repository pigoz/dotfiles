export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="jreese"
plugins=(rails git ruby textmate)
source $ZSH/oh-my-zsh.sh
unsetopt correct_all

# some utf-8 support
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
alias ls='ls -Gw'
alias ll='ls -Glw'         # standard vertical listing
alias la='ls -GAlw'        # show hidden files

alias pg.start='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pg.stop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'

# point java_home to system java
# export JAVA_HOME=$(/usr/libexec/java_home)

# aliases
alias -g be='bundle exec'
alias -g sudo='nocorrect sudo'
alias -g cay='cd ~/dev/cayenne'

vundle-install() {
  vim +BundleInstall +qall
}

vundle-update() {
  vim +BundleInstall! +qall
}

yt() {
  video=$1
  quality=${2:=360p}
  livestreamer "http://www.youtube.com/watch?v=$video" $quality
}

# $1 search
# $2 replace
prjreplace() {
  ag -Sl "$1" | xargs perl -pi -E "s/$1/$2/g"
}

sprunge() {
  curl -F 'sprunge=<-' http://sprunge.us
}

sprunge-cb() {
  pbpaste | curl -F 'sprunge=<-' http://sprunge.us
}

what-the-commit() {
   git commit -m "$(curl --silent http://whatthecommit.com/index.txt)"
}

remote-sha1() {
  curl $1 | openssl sha1
}

bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word
bindkey '^[[5D' beginning-of-line
bindkey '^[[5C' end-of-line

export PKG_CONFIG_PATH=/usr/local/opt/libass-ct/lib/pkgconfig:$PKG_CONFIG_PATH

alias mpv4k='./mpv -demuxer-rawvideo w=4000:h=2000 -demuxer rawvideo /dev/zero'

source ~/.paths

# Aliases
source ~/.localrc


source ~/.z.sh

# added by travis gem
[ -f /Users/pigoz/.travis/travis.sh ] && source /Users/pigoz/.travis/travis.sh
