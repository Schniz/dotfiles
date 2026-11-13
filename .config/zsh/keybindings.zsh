# emacs keybindings
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^L' clear-screen

# Treat / as a word boundary when deleting words.
WORDCHARS=${WORDCHARS//\/}
bindkey '^W' backward-kill-word

autoload edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line
