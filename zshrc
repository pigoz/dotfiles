# PATH setup (before compinit, so it sees brew completions)
source ~/.zshpath

autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select

HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=10000
setopt extended_history hist_expire_dups_first hist_ignore_dups hist_ignore_space hist_verify share_history
setopt interactive_comments

# emacs keys: zsh would pick vi mode because EDITOR is nvim
bindkey -e
# up/down search history for what's already typed
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[OA' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey '^[OB' down-line-or-beginning-search

# some utf-8 support
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
alias ls='ls -Gw'
# oh-my-zsh colors: bold cyan directories (macOS default is blue)
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export LS_COLORS="di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

mvim() {
  nvim-qt $*
}

export EDITOR=nvim
export VISUAL=nvim-qt

export CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING=1

gitx() {
  lazygit
}

# aliases
alias -g be='bundle exec'

upload-file() {
  curl -F "file=@$1" https://0x0.st
}

upload-cb() {
  pbpaste | curl -F'file=@-' https://0x0.st
}

bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word
bindkey '^[[5D' beginning-of-line
bindkey '^[[5C' end-of-line

oc() {
  bunx opencode-ai "$@"
}

playwright-cli() {
  bunx @playwright/cli "$@"
}

# Secrets
[ -f ~/.localrc ] && source ~/.localrc

eval "$(starship init zsh)"
