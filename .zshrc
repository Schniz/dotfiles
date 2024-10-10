set -kJ

autoload -Uz compinit
setopt INC_APPEND_HISTORY
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

zinit ice wait"0" lucid
zinit light htlsne/zinit-rbenv

zinit wait lucid for OMZL::history.zsh

# install completions
zi ice as"completion"
zi snippet OMZP::docker/completions/_docker
zi ice as"completion"
zi snippet OMZP::docker-compose/_docker-compose

export EDITOR=nvim
export GOPATH=$HOME/Code/go

# emacs keybindings
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^L' clear-screen

autoload edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/bin:$HOME/Library/Haskell/bin/:$GOPATH:$HOME/.rvm/bin:$HOME/Code/go/bin:$HOME/.gpkg/bin:node_modules/.bin:../node_modules/.bin:../../node_modules/.bin:../../../node_modules/.bin:/usr/local/opt/llvm/bin:/Users/schniz/.luarocks/bin"
export PATH="$HOME/Code/dotfiles/bin:$HOME/Code/fnm/target/debug:$HOME/Code/gpkg/target/debug:$HOME/.gpkg/bin:$HOME/.cargo/bin:/opt/homebrew/opt/util-linux/bin:$PATH:$GOPATH/bin:./node_modules/.bin:../node_modules/.bin:../../node_modules/.bin"

# fnm
eval "$(fnm env --use-on-cd --version-file-strategy=recursive --corepack-enabled --resolve-engines)"

source ~/.dotfiles/aliases

# Load all custom zsh functions
for file in ~/.dotfiles/zsh-functions/*; do
  source $file
done

if [ -f ~/.secrets ]; then
  source ~/.secrets
fi

configkube() {
  source <(kubectl completion zsh)
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

if [ ! "$TMUX" = "" ]; then export TERM=xterm-256color; fi

source <(starship init zsh)

function cdgr() {
  cd $(gitroot)
}

# Bun
export BUN_INSTALL="/Users/schniz/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# bun completions
# [ -s "/Users/schniz/.bun/_bun" ] && source "/Users/schniz/.bun/_bun"

# function screenshell() {
#   if [ "$STARSHIP_CONFIG" = "" ]; then
#     export STARSHIP_CONFIG=~/.config/starship-screenshot.toml
#   else
#     unset STARSHIP_CONFIG
#   fi
# }

# pnpm
export PNPM_HOME="/Users/schniz/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

export BAT_THEME='Dracula'
export NVIM_APPNAME='schnizvim'
