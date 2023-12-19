set -kJ

autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist

# zi
if [[ ! -d ~/.zi ]]; then
  mkdir ~/.zi
  git clone https://github.com/z-shell/zi.git ~/.zi/bin
fi
source "$HOME/.zi/bin/zi.zsh"

autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi

# zi plugins
zi ice lucid wait"0" atinit"zpcompinit; zpcdreplay"
zi light zdharma/fast-syntax-highlighting

# # 0 -- vanilla completion (abc => abc)
# 1 -- smart case completion (abc => Abc)
# 2 -- word flex completion (abc => A-big-Car)
# 3 -- full flex completion (abc => ABraCadabra)
zstyle ':completion:*' matcher-list '' \
  'm:{a-z\-}={A-Z\_}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
  'r:|?=** m:{a-z\-}={A-Z\_}'
# use fzf for tab completion
# zinit light Aloxaf/fzf-tab

zi ice lucid wait"0" blockf
zi light zsh-users/zsh-completions

export EDITOR=nvim
export GOPATH=$HOME/Code/go

# emacs keybindings
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^L' clear-screen

autoload edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# rbenv
if command -v rbenv &> /dev/null; then
  export PATH="$HOME/.rbenv/bin:/usr/local/opt/python/libexec/bin:$PATH"
  eval "$(rbenv init -)"
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/bin:$HOME/Library/Haskell/bin/:$GOPATH:$HOME/.rvm/bin:$HOME/Code/go/bin:$HOME/.gpkg/bin:node_modules/.bin:../node_modules/.bin:../../node_modules/.bin:../../../node_modules/.bin:/usr/local/opt/llvm/bin:/Users/schniz/.luarocks/bin"
export PATH="$HOME/Code/fnm/target/debug:$HOME/Code/gpkg/target/debug:$PATH"

# fnm
eval "$(fnm env --use-on-cd --version-file-strategy=recursive --corepack-enabled --resolve-engines)"

source ~/.dotfiles/aliases

# OPAM configuration
. $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

function pyenv_enable() {
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
}

# Codi
# Usage: codi [filetype] [filename]
codi() {
  local syntax="${1:-python}"
  shift
  vim -c \
    "let g:startify_disable_at_vimenter = 1 |\
    set bt=nofile ls=0 noru nonu nornu |\
    hi ColorColumn ctermbg=NONE |\
    hi VertSplit ctermbg=NONE |\
    hi NonText ctermfg=0 |\
    Codi $syntax" "$@"
}

configkube() {
  source <(kubectl completion zsh)
}

source ~/.secrets

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

fpath+=~/.zfunc
compinit

if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

if [ ! "$TMUX" = "" ]; then export TERM=xterm-256color; fi

function cdgr() {
  cd $(gitroot)
}

source <(starship init zsh)

# bun completions
[ -s "/Users/schniz/.bun/_bun" ] && source "/Users/schniz/.bun/_bun"

# Bun
export BUN_INSTALL="/Users/schniz/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

function screenshell() {
  if [ "$STARSHIP_CONFIG" = "" ]; then
    export STARSHIP_CONFIG=~/.config/starship-screenshot.toml
  else
    unset STARSHIP_CONFIG
  fi
}

# pnpm
export PNPM_HOME="/Users/schniz/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

export BAT_THEME='Dracula'
