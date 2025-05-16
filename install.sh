#!/bin/bash
set -e

ZSH_DIR="${HOME}/.zsh"

_help() {
  cat <<EOF
Usage: $(basename $0) TARGET

TARGETS
  a,all       Everything.
  g,git       Install gitconfig into ~/
  s,aspell    Install aspell dicitonaries into ~/
  z,zsh       Add zshrc to ~/, then create $ZSH_DIR add add zle.zsh.
  h,help      Show this help menu.
EOF
}

# The thing that you're installing.
TARGET="$1"

_install_aspell() {
  cp ./aspell/aspell.en.prepl "$HOME"
  cp ./aspell/aspell.en.pws "$HOME"
  echo "aspell dictionaries installed"
}

_install_git() {
  cp ./git/gitconfig "${HOME}/.gitconfig"
  echo "git config installed"
}

_install_all() {
  _install_aspell
  _install_git
  _install_zsh
}

_install_zsh() {
  cp ./zsh/zshrc "${HOME}/.zshrc"
  mkdir -p "$ZSH_DIR"
  cp ./zsh/zle.zsh "${ZSH_DIR}/"
  echo "zsh config installed"
}

case "$TARGET" in
a | all) _install_all ;;
g | git) _install_git ;;
s | aspell) _install_aspell ;;
z | zsh) _install_zsh ;;
*) echo -e "Unknown target: '$TARGET'\n" && _help ;;
esac
