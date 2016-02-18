fpath=(/usr/local/share/zsh/site-functions $fpath)
autoload -U compinit
compinit

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

pg_dir='/usr/local/var/postgres'

pg.start() {
  pg_ctl -D $pg_dir -l $pg_dir/server.log start
}

pg.stop() {
  pg_ctl -D $pg_dir stop -s -m fast
}

mongo_plist='/usr/local/opt/mongodb/homebrew.mxcl.mongodb.plist'

mongo.start() {
  launchctl load $mongo_plist
}

mongo.stop() {
  launchctl unload $mongo_plist
}

redis_plist="/usr/local/opt/redis/homebrew.mxcl.redis.plist"

redis.start() {
  launchctl load $redis_plist
}

redis.stop() {
  launchctl unload $redis_plist
}

# point java_home to system java
# export JAVA_HOME=$(/usr/libexec/java_home)

# aliases
alias -g be='bundle exec'
alias -g sudo='nocorrect sudo'

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

f() {
  ag --smart-case --skip-vcs-ignores $1
}

sprunge() {
  curl -F 'sprunge=<-' http://sprunge.us
}

sprunge-cb() {
  pbpaste | curl -F 'sprunge=<-' http://sprunge.us
}

upload-image() {
  curl -F "file=@$1" https://0x0.st
}

what-the-commit() {
   git commit -m "$(curl --silent http://whatthecommit.com/index.txt)"
}

remote-sha1() {
  curl $1 | openssl sha1
}

bigscp() {
  rsync -avz --partial --progress --rsh=ssh $1 $2
}

solr-reindex() {
  bundle exec rake sunspot:solr:reindex
}

rpi.dump() {
  if [ -z  "$1" ] || [ -z "$2" ] ; then
    echo 'USAGE: rpi.dump /dev/disk3 $HOME/image.gz'
  else
    sudo dd if="$1" bs=1m | gzip > "$2"
  fi
}

rpi.flash() {
  if [ -z  "$1" ] || [ -z "$2" ] ; then
    echo 'USAGE: rpi.flash /dev/disk3 $HOME/image.gz'
  else
    diskutil unmountDisk "$1"
    gzip -dc "$2" | sudo dd of="$1" bs=1m
  fi
}

bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word
bindkey '^[[5D' beginning-of-line
bindkey '^[[5C' end-of-line

# Tmux productivity stuff
source ~/.zshtmux

# Aliases
source ~/.localrc

# PATH setup
source ~/.zshpath

# added by travis gem
[ -f /Users/pigoz/.travis/travis.sh ] && source /Users/pigoz/.travis/travis.sh
