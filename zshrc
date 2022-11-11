fpath=(/usr/local/share/zsh/site-functions $fpath)
autoload -U compinit
compinit

export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="jreese"
export NVM_LAZY=1
plugins=(git ruby nvm)
source $ZSH/oh-my-zsh.sh
unsetopt correct_all

# some utf-8 support
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
alias ls='ls -Gw'
alias ll='ls -Glw'         # standard vertical listing
alias la='ls -GAlw'        # show hidden files

mvim() {
  nvim-qt $*
}

export EDITOR=nvim
export VISUAL=nvim-qt

pg_dir='/usr/local/var/postgres'

lg() {
  lazygit
}

gitx() {
  lazygit
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

# aliases
alias -g be='bundle exec'
alias -g sudo='nocorrect sudo'

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

vim-reset() {
  rm -rf ~/.local/share/nvim ~/.config/nvim/plugin/packer_compiled.lua
}

bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word
bindkey '^[[5D' beginning-of-line
bindkey '^[[5C' end-of-line

# Aliases
source ~/.localrc

# PATH setup
source ~/.zshpath
