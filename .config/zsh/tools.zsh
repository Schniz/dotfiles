export EDITOR=nvim
export GOPATH="$HOME/Code/go"
export BUN_INSTALL="$HOME/.bun"
export PNPM_HOME="$HOME/Library/pnpm"
export BAT_THEME='base16'
export NVIM_APPNAME='schnizvim'
export NI_CONFIG_FILE="$HOME/.config/ni/nirc"

typeset -U path PATH
path=(
  "$BUN_INSTALL/bin"
  "$PNPM_HOME"
  "$HOME/Code/dotfiles/bin"
  "$HOME/Code/fnm/target/debug"
  "$HOME/Code/gpkg/target/debug"
  "$HOME/.gpkg/bin"
  "$HOME/.cargo/bin"
  /opt/homebrew/bin
  /opt/homebrew/opt/util-linux/bin
  $path
  "$GOPATH/bin"
  ./node_modules/.bin
  ../node_modules/.bin
  ../../node_modules/.bin
  "$HOME/.maestro/bin"
)

if command -v fnm >/dev/null; then
  eval "$(fnm env --shell=zsh --use-on-cd --version-file-strategy=recursive --corepack-enabled --resolve-engines)"
fi

configkube() {
  source <(kubectl completion zsh)
}

# fzf and zoxide - load synchronously (fast enough)
command -v fzf &>/dev/null && source <(fzf --zsh)
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"

if [[ -n "$TMUX" ]]; then
  export TERM=xterm-256color
fi

# starship - use --print-full-init to avoid subshell
if command -v starship >/dev/null; then
  eval "$(starship init zsh --print-full-init)"
fi

if [[ -f "$GHOSTTY_RESOURCES_DIR/shell-integration/zsh/ghostty-integration" ]]; then
  source "$GHOSTTY_RESOURCES_DIR/shell-integration/zsh/ghostty-integration"
fi
