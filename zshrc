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

mvim() {
  vimr $*
}

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
  # ~/dev/fps/fps.rb ${@: -1}
  mpv-cli --volume=70 --fullscreen --display=1 $*
}

# point java_home to system java
# export JAVA_HOME=$(/usr/libexec/java_home)

# aliases
alias -g be='bundle exec'
alias -g sudo='nocorrect sudo'

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

brewcurl() {
  PATH="/usr/local/opt/curl/bin:$PATH" curl $*
}

upload-file() {
  brewcurl -F "file=@$1" https://0x0.st
}

upload-cb() {
  pbpaste | brewcurl -F'file=@-' https://0x0.st
}

upload() {
  brewcurl -F'file=@-' https://0x0.st
}

remote-sha1() {
  curl $1 | openssl sha1
}

bigscp() {
  rsync -avz --partial --progress --rsh=ssh $1 $2
}

subs.ass2srt() {
  find . -name \*.ass | sed 's/\.ass$//' | xargs -I{} ffmpeg -i {}.ass -c:s text {}.srt
}

subs.retimemkv() {
  find . -name \*.srt | sed 's/\.srt$//' | xargs -I{} alass-cli {}.mkv {}.srt {}.srt
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

PATH="/Users/pigoz/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/pigoz/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/pigoz/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/pigoz/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/pigoz/perl5"; export PERL_MM_OPT;
