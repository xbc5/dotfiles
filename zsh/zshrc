######################################################################
#                             VARIABLES                              #
######################################################################
# Where user binaries go.
USER_BIN="${HOME}/.local/bin"


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
# Do this after other binaries (above) because I can shim system installs.
mkdir -p "$USER_BIN"
export PATH="${USER_BIN}:${PATH}"

# PYENV
# Do this after other bianries (above) because it shims Python packages.
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


######################################################################
#                              ALIASES                               #
######################################################################
# Declare the absolutely last, so that they override binaries.
alias x="xclip -selection clipboard"
alias zshrc="$EDITOR ${HOME}/.zshrc"
alias reload="source ${HOME}/.zshrc"
alias gitconfig="$EDITOR ${HOME}/.gitconfig"

ubi () {
  case "$1" in
    i|install)
      curl --silent --location https://raw.githubusercontent.com/houseabsolute/ubi/master/bootstrap/bootstrap-ubi.sh \
        | TARGET="$USER_BIN" sh 
      ;;
    l|lazygit) command ubi --in "$USER_BIN" --project jesseduffield/lazygit;;
    *) command ubi --in "$USER_BIN" ;;
  esac
  
}

rg () {
  command rg --json -C 2 "$@" | delta
}


export PATH
