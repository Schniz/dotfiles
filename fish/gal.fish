#!/usr/bin/env fish

export NVM_DIR=~/.nvm
#source (brew --prefix nvm)/nvm.sh

export PATH="$PATH:$HOME/.rvm/bin:$HOME/Code/vert.x-3.1.0/bin:./node_modules/.bin" # Add RVM to PATH for scripting
#alias vim='/usr/local/Cellar/vim/7.4.488/bin/vim'
alias vim=nvim
# Base16 Shell
eval sh ~/.config/base16-shell/base16-eighties.dark.sh
