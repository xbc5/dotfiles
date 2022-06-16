ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
source "${ZINIT_HOME}/zinit.zsh"

setopt auto_pushd # make cd use pushd automatically
setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt auto_cd # cd by typing directory name if it's not a command
#setopt correct_all # autocorrect commands
# completion
setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt glob_complete # limit completions with globs
setopt menu_complete # fill suggestion on first tab (request)
setopt list_types # show tailing file types
setopt list_rows_first # horizontal movement by default
setopt always_to_end # move cursor to end if word had one match

# history
mkdir --parents "${HOME}/.cache/zsh" # zsh won't create dir, and hist isn't saved
HISTSIZE=20000 # make this at least 20% larger that SAVEHIST, else can't dedupe
SAVEHIST=10000
HISTFILE="${HOME}/.cache/zsh/history"
setopt inc_append_history # save history entries as soon as they are entered
setopt share_history # share history between different instances of the shell

# ENV
export CARGO_HOME="${HOME}/.cargo"
export CHROME_BIN="chromium-freeworld" # for `ng test`
export GIT_LREPOS="${HOME}/git"
export NPM_PACKAGES="${HOME}/.npm-packages"
export PAGER="less"
export PYTHONPATH_USER="${HOME}/.local/bin"
export PYENV_ROOT="${HOME}/.pyenv"
export PGPASSFILE="${HOME}/.pgpass"

export IDE="kitty --class=ide --detach nvim"

export FZF_DEFAULT_OPTS="--border --color=16"
export DEV_PROJECTS="${HOME}/projects"
export DEV_PRACTICE="${HOME}/practice"
export DEV_DIRS="${DEV_PROJECTS}:${DEV_PRACTICE}"

PATH="$PATH";
PATH+=":${HOME}/.pyenv/bin";
PATH+=":${PYENV_ROOT}";
PATH+=":${CARGO_HOME}/bin";
PATH+=":${PYTHONPATH_USER}";
PATH+=":${HOME}/bin";
PATH+=":${HOME}/.emacs.d/bin";
PATH+=":${HOME}/.luarocks/bin";
PATH+=":${HOME}/WIP";
PATH+=":${NPM_PACKAGES}/pnpm-bin";
[[ `command -v go` ]] && PATH+=":$(go env GOPATH)/bin";
export PATH;

conf="${HOME}/.config"
FUZZY_OPEN_TARGETS="${HOME}:1;"
FUZZY_OPEN_TARGETS+="${HOME}/doc:X;"
FUZZY_OPEN_TARGETS+="${HOME}/projects:X;"
FUZZY_OPEN_TARGETS+="${HOME}/org:X;"
FUZZY_OPEN_TARGETS+="${HOME}/WIP:X;"
FUZZY_OPEN_TARGETS+="${HOME}/git:X;"
FUZZY_OPEN_TARGETS+="${HOME}/dl:X;"
FUZZY_OPEN_TARGETS+="${HOME}/tmp:X;"
FUZZY_OPEN_TARGETS+="${conf}/Code/User:X;"
FUZZY_OPEN_TARGETS+="${conf}/xfce4/terminal:X"
export FUZZY_OPEN_TARGETS

# Qubes split-ssh: listen on the ssh socket, then send it to ssh VM
# if ! [[ -e "$SSH_AUTH_SOCK" ]]; then
#   socat \
#     UNIX-LISTEN:$SSH_AUTH_SOCK,unlink-early,reuseaddr,fork \
#     EXEC:"qrexec-client-vm @dispvm qubes.SshAgent+dev" & # via dispvm, and through specified policy
# fi

# PLUG-INS
# git
zinit ice lucid wait
zinit snippet OMZ::lib/git.zsh # provides git_current_branch(), and others
zinit ice lucid wait
zinit snippet OMZ::plugins/git/git.plugin.zsh
# gitignore: gi
zinit ice lucid wait
zinit snippet OMZ::plugins/gitignore/gitignore.plugin.zsh
# ssh-agent
# using split-ssh (via socat) instead
zinit ice lucid wait
zinit snippet OMZ::plugins/ssh-agent/ssh-agent.plugin.zsh
# tmux
zinit ice lucid wait
zinit snippet OMZ::plugins/tmux/tmux.plugin.zsh
# fzf command history
zinit ice lucid wait'0'
zinit light joshskidmore/zsh-fzf-history-search
# fzf tab complete everything
zinit light Aloxaf/fzf-tab
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa \
 --color=always --classify --icons --long --no-permissions \
 --no-time --git --no-filesize $realpath'
# wd plug-in
zinit ice wait lucid svn
zinit snippet OMZ::plugins/wd

# load auto-completion engine, must be after plug-ins, and before any cdreplay
# https://github.com/zdharma/zinit#completions-2
autoload -Uz compinit && compinit

# kubectl: aliases + completions
# broken
#zinit ice wait lucid atload"zicdreplay"
#zinit snippet OMZ::plugins/kubectl/kubectl.plugin.zsh
# docker
zinit ice wait lucid atload"zpcdreplay" atpull"zinit creinstall -q ."
zinit light greymd/docker-zsh-completion
# general / multi
#zinit ice wait lucid blockf atpull"zinit creinstall -q ."
#zinit light zsh-users/zsh-completions
# must be loaded last: https://zdharma.org/zinit/wiki/Example-Minimal-Setup/
#zinit ice wait lucid atload"_zsh_autosuggest_start"
#zinit light zsh-users/zsh-autosuggestions

# SOURCES
# zsh line editor - e.g. key-binds etc.
source "${HOME}/.zsh/zle.zsh"
# load custom, untracked plug-ins
#for f in ${HOME}/.zsh/plugins/*; do . ${f}; done; # don't source as string

black=`tput setaf 0`
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
cyan=`tput setaf 6`
white=`tput setaf 7`

bold=`tput bold`
reset=`tput sgr0`

function setup() {
  # quickly initialise tools for a dev environment

  [[ `command -v go` ]] || echo "you need to install go, then rerun this command";

  # kind: docker in docker for Kubernetes
  # `go env GOPATH` should be included in PATH first
  if ! [ `command -v kind` ] && [ `command -v go` ]; then
    echo "installing kind..";
    GO111MODULE="on" go get sigs.k8s.io/kind@latest
  fi
}

function pull_docs() {
  # use subshell so that the working directory can be changed
  (
    out_dir="${HOME}/doc/docsets"
    docs=(
      "Bash"
      "Bootstrap_4"
      "Bootstrap_5"
      "C"
      "CSS"
      "Common_Lisp"
      "Docker"
      "Emacs_Lisp"
      "Express"
      "Font_Awesome"
      "Go"
      "HTML"
      "JavaScript"
      "LaTeX"
      "Markdown"
      "NodeJS"
      "PostgreSQL"
      "Python_3"
      "React"
      "Sass"
      "TypeScript"
      "Vim"
      "WordPress"
    )

    docsets=`echo $docs | sed 's/ /, /g'`;
    echo "docsets to be fetched: $docsets\n";

    cd "${HOME}/git/feeds";
    git checkout master > /dev/null 2>&1;
    
    for doc in "${docs[@]}"; do
      url=`xpath -q -e '//entry/url[1]/text()' ${doc}.xml`;
      surl=`echo $url | sed 's/^http:\/\//https:\/\//'`; # convert to TLS
      out_file="${out_dir}/${doc}.tgz"
      
      echo -n "fetching ${bold}${doc}${reset} docs.. ${reset}";
      curl --tlsv1.3 $surl --output $out_file > /dev/null 2>&1;
      
      if [[ $? == 0 ]]; then
        echo "${green}${bold}ok${reset}"
        (
          cd $out_dir && tar xf $out_file && shred -un 1 $out_file
        )
      else
        echo "${red}${bold}failed${reset}";
      fi
    done
  )
}

function svelte-init() {
  npx degit sveltejs/template "$1" \
    && (cd "$1" \
          && node scripts/setupTypeScript.js \
          && npm install)
}

# git
alias dot="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias gsf="git ls-tree --full-tree -r HEAD";  #  show all repo files
# common spelling mistakes
alias ha="ga"; # git plugin
# services
alias start="sudo systemctl start";
alias stop="sudo systemctl stop";
alias restart="sudo systemctl restart";
alias status="sudo systemctl status";
alias show="sudo systemctl | grep -i";
# pyenv
alias pc="pyenv virtualenv";
# alias pl="pyenv virtualenvs";
alias ph="pyenv help";
alias pv="pyenv versions";
alias pa="pyenv activate";
alias pd="pyenv deactivate";

alias p="pnpm";
alias pr="pnpm run";
alias pt="reset && pnpm run test --";
alias pl="reset && pnpm run check:lint --";
alias pad="pnpm add --save-dev";
alias pa="pnpm add";
alias y="\yarn";
alias yarn="echo 'no; use y or p'";

alias gil="gh issue list -L 1000";
alias gill="gh issue list -L 1000 -l";
alias gicr="gh issue create";
alias gico="gh issue comment --editor"
alias gicl="gh issue close"
alias gie="gh issue edit";
alias gn="gh notify";
alias grf="gh repo fork --clone --remote"
alias giv="gh issue view --comments"

# exa
export TIME_STYLE=long-iso
export EXA_STRICT=true
alias exa="exa --color=always --classify --icons --created"
alias ls="exa"
alias lsa="exa --long --git"
alias lst="exa --long --git --sort created"

# zsh
alias zlerc="$EDITOR ${HOME}/.zsh/zle.zsh && reload"
alias reload="source ${HOME}/.zshrc && echo reload: zshrc reloaded";
alias zshrc="$EDITOR ${HOME}/.zshrc && reload"
alias vim="echo nope."

function sa() {
  local key="`ls ${HOME}/.ssh/*.priv | fzf`"
  [[ key == "" ]] && return
  ssh-add "${key}"
}

# pyenv - add a number of paths, also this modified PATH,
#  so needs to be at the end of this file
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# remove duplicates from paths, this happens when re-sourcing zshrc
typeset -aU path
typeset -aU fpath

zinit cdreplay -q

if [[ -z "`command -v starship`" ]]; then
  echo "You must install starship manually: gh install starship/starship"
else
  eval "$(starship init zsh)"
fi
