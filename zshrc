fpath=(/usr/local/share/zsh/site-functions $fpath)
autoload -U compinit
compinit

export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="jreese"
export EDITOR=vim
plugins=(rails git ruby zsh-nvm)
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

subdl() {
  subliminal --debug download --language=en --single -f $*
}

mc() {
  # brew install switchaudio-osx
  SwitchAudioSource -s HDMI
  ~/dev/fps/fps.rb ${@: -1}
  mpv -fs -screen=1 $*
  SwitchAudioSource -s "Built-in Output"
}

mch() {
  ~/dev/fps/fps.rb ${@: -1}
  mpv --volume=43 -fs -screen=1 $*
}

yarr() {
  src="/home/debian-transmission/Downloads"
  dst="/Volumes/Mechanical Disk/Movies (External)/Downloads"
  cd $dst
  lftp sftp://loli.wakku.to:$src
}

# point java_home to system java
# export JAVA_HOME=$(/usr/libexec/java_home)

# aliases
alias -g be='bundle exec'
alias -g sudo='nocorrect sudo'

plug-install() {
  vim +PlugInstall +qall
}

plug-update() {
  vim +PlugUpdate +qall
}

yt() {
  video=$1
  quality=${2:=360p}
  livestreamer "http://www.youtube.com/watch?v=$video" $quality
}

# $1 search
# $2 replace
# prjreplace() {
#   ag -Sl "$1" | xargs perl -pi -E "s/\Q$1\E/\Q$2\E/g"
# }
#
prjreplace() {
  self=$(readlink ~/.zshrc)
  dir=$(dirname $self)
  replacebin=$dir/bin/replace
  ag -Sl "$1" | xargs -L 1 "$replacebin" "$1" "$2"
}

f() {
  ag --smart-case --skip-vcs-ignores $1
}

upload-file() {
  curl -F "file=@$1" https://0x0.st
}

upload-cb() {
  pbpaste | curl -F'file=@-' https://0x0.st
}

upload() {
  curl -F'file=@-' https://0x0.st
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

yt-playlist() {
  mpv --volume=50 --no-video --term-playing-msg='Title: ${media-title}' https://www.youtube.com/playlist\?list\=$1
}

yt-music() {
  mpv --volume=50 --no-video --term-playing-msg='Title: ${media-title}' https://www.youtube.com/watch\?v\=$1
}

subs.ass2srt() {
  find . -name \*.ass | sed 's/\.ass$//' | xargs -I{} ffmpeg -i {}.ass -c:s text {}.srt
}

subs.retimemkv() {
  find . -name \*.srt | sed 's/\.srt$//' | xargs -I{} alass-cli {}.mkv {}.srt {}.srt
}

music.miku() {
  yt-playlist PLLoRe_7Ei6nQ1vgFyVWxNVz2gjPFC7LIA
}

music.persona5() {
  yt-music 30Ef7i3qq-U
}

music.persona4() {
  yt-music vUjVFZN25Eg
}

music.nier() {
  yt-music 8D6kHaJd2Iw
}

music.jpophits() {
  mpv --volume=100 --no-video --term-playing-msg='Title: ${media-title}' http://192.99.62.212:9764/stream
}

mkavatar() {
  file="$(mktemp -t kanji).png"
  font='/System/Library/Fonts/ヒラギノ角ゴシック W6.ttc'
  convert -size 200x200 -pointsize 190 -gravity center -font $font caption:"$1" $file
  upload-file $file
  echo "image: $file"
}

mount.veda() {
  sshfs pigoz@veda.local:/var/lib/transmission-daemon/downloads /Volumes/veda -o volname=veda
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

# OPAM configuration
source ~/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
