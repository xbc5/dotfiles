# explicitly use vi mode, although EDITOR=vim does the same
bindkey -v
# zsh-autosuggest plugin, execute suggestion
bindkey "^ " autosuggest-execute
bindkey "^a" beginning-of-line
bindkey "^e" end-of-line

# >>> GIT >>>
# git commit --all
function git-commit-all() {
  BUFFER="git commit --all"
  zle accept-line
}
zle -N git-commit-all
bindkey "\ec" git-commit-all  # <alt>c
#
#git commit --all --message
function git-commit-all-message() {
  local message=$BUFFER
  BUFFER="git commit --all --message \"${message}\""
  zle accept-line
}
zle -N git-commit-all-message
bindkey "\e^M" git-commit-all-message  # <alt>Enter

