# emacs keybindings
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^L' clear-screen

autoload edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line
