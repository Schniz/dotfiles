set -kJ
setopt INC_APPEND_HISTORY

source "$HOME/.config/zsh/completions.zsh"
source "$HOME/.config/zsh/zi.zsh"
source "$HOME/.config/zsh/keybindings.zsh"
source "$HOME/.config/zsh/tools.zsh"
source "$HOME/.config/zsh/aliases"

for file in "$HOME/.config/zsh/functions/"*; do
  [[ -f "$file" ]] && source "$file"
done

[[ -f "$HOME/.secrets" ]] && source "$HOME/.secrets"
