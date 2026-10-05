# zi
if [[ ! -f "$HOME/.zi/bin/zi.zsh" ]] && command -v git >/dev/null; then
  mkdir -p "$HOME/.zi"
  git clone https://github.com/z-shell/zi.git "$HOME/.zi/bin"
fi

if [[ -f "$HOME/.zi/bin/zi.zsh" ]]; then
  # Plugin updates can remove completion files without removing Zi's symlinks.
  # compinit attempts to load those dangling links and prints an error for each.
  for completion in "$HOME/.zi/completions"/*(N); do
    [[ -L "$completion" && ! -e "$completion" ]] && rm -f -- "$completion"
  done

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

  if command -v rbenv &> /dev/null; then
    zi ice wait"0" lucid
    zi light htlsne/zinit-rbenv
  fi

  zi wait lucid for OMZL::history.zsh
  zi wait lucid for OMZP::direnv

  # install completions
  zi ice as"completion"
  zi snippet OMZP::docker/completions/_docker
  zi ice as"completion"
  zi snippet OMZP::docker-compose/_docker-compose
fi
