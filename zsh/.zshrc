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
export PAGER="less -R"
export PYTHONPATH_USER="${HOME}/.local/bin"
export PYENV_ROOT="${HOME}/.pyenv"
export PGPASSFILE="${HOME}/.pgpass"

export FZF_DEFAULT_OPTS="--border --color=16"

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

# docker
zinit ice wait lucid atload"zpcdreplay" atpull"zinit creinstall -q ."
zinit light greymd/docker-zsh-completion

# SOURCES
# zsh line editor - e.g. key-binds etc.
source "${HOME}/.zsh/zle.zsh"

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

# git
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
alias reload="source ${HOME}/.zshrc && echo reload: zshrc reloaded";
alias zshrc="$EDITOR ${HOME}/.zshrc && reload"

# common
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
