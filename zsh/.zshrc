######################################################################
#                              ALIASES                               #
######################################################################
alias x="xclip -selection clipboard"
alias zshrc="$EDITOR ${HOME}/.zshrc"
alias reload="source ${HOME}/.zshrc"
alias gitconfig="$EDITOR ${HOME}/.gitconfig"

rg () {
  if delta -h &>/dev/null; then
    command rg --json -C 2 "$@" | delta
  else
    command rg $@
  fi
}


######################################################################
#                                PATH                                #
######################################################################
if go -h &>/dev/null; then
  PATH+=":${HOME}/go/bin"
fi

# ZELLIJ
if zellij -h &>/dev/null; then
  eval "$(zellij setup --generate-auto-start zsh)"
  source <(fzf --zsh)
fi

# PLEASE
if plz -h &>/dev/null; then
  PATH+=":${HOME}/.please" # does it twice for some reason
  eval "$(plz --completion_script)"  # doesn't work
fi

# MISE
if mise -h &>/dev/null; then
  eval "$(mise activate zsh)"
fi

# PNPM
# pnpm
export PNPM_HOME="${HOME}/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# LOCAL BIN
# Do this last because I can shim system installs.
mkdir -p "${HOME}/.local/bin"
export PATH="${HOME}/.local/bin:${PATH}"

# PYENV
# Do this last because it shims Python packages.
if pyenv -h &>/dev/null; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi


######################################################################
#                             SHELL INIT                             #
######################################################################
# ZINIT
if [[ -f "/usr/scripts/init-zinit" ]]; then
   source /usr/scripts/init-zinit
fi

export PATH
