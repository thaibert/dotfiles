#!/bin/bash

_PREPEND="[init]"
_stdout() {
  echo "$_PREPEND $1"
}

_stderr() {
  >&2 echo "$_PREPEND $1"
}

_error_with_message() {
  _stderr "Error during environment setup: $1"
  exit 1
}


## Determining OS type
os="$(uname -s)" # -s is --kernel-name
case "${os}" in
  Linux*) {
    machine="linux"
    if (grep --quiet --ignore-case "microsoft" /proc/version); then
      machine="wsl"
    fi 
    if (grep --ignore-case "^name=" /etc/os-release | grep --quiet --ignore-case "fedora"); then
      machine="linux-fedora"
    fi
  } ;;
  Darwin*) {
    machine="mac"
  } ;;
  *) {
    _error_with_message "Unknown OS type: $os"
  } ;;
esac

export _OS_TYPE=$machine
_stdout "OS type determined to be: $_OS_TYPE"


## Installation and setup
_PREPEND="[install]"
_stdout "Starting installation"
case "$_OS_TYPE" in
  mac*) {
    _stdout "Ensuring homebrew is installed"
    brew --version
    if [[ $? != 0 ]]; then
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    _stdout "Installing homebrew packages"
    brew bundle install --no-lock

    _stdout "Setting up zsh"
    stow --no-folding --verbose --target="$HOME" zsh
    _antigen_zsh=$(find $(brew --prefix)/Cellar/antigen | grep antigen.zsh)
    ln -s -f -v "$_antigen_zsh" "$HOME/.zsh/antigen.zsh"

    _stdout "Setting up vim"
		stow --no-folding --verbose --target="$HOME" vim

    _stdout "Setting up tmux"
		stow --no-folding --verbose --target="$HOME" tmux
    ln -s -f -v "$HOME/.tmux/paste-mac.sh" "$HOME/.tmux/paste.sh"

    _stdout "Setting up alacritty"
		stow --no-folding --verbose --target="$HOME" alacritty
    ln -s -f -v "$HOME/.config/alacritty/alacritty-mac.yml" "$HOME/.config/alacritty/alacritty.yml"
  };;
  wsl*) {
    sudo apt-get install -y stow
    wget -q -O "$HOME/.antigen.vendored.zsh" "https://raw.githubusercontent.com/zsh-users/antigen/develop/bin/antigen.zsh"  # TODO: Debian's zsh-antigen package is broken, so vendor it in manually
    mkdir -p "$HOME/.config/alacritty"
    mkdir "$HOME/.tmux" 2>/dev/null
    mkdir "$HOME/.zsh" 2>/dev/null
    if [ -f "$HOME/.zshrc" ]; then
      mv "$HOME/.zshrc" "$HOME/.old_zshrc"
    fi

    _stdout "Setting up zsh"
    stow --no-folding --verbose --target="$HOME" zsh
    _antigen_zsh="$HOME/.antigen.vendored.zsh"
    ln -s -f -v "$_antigen_zsh" "$HOME/.zsh/antigen.zsh"

    _stdout "Setting up vim"
		stow --no-folding --verbose --target="$HOME" vim

    _stdout "Setting up tmux"
		stow --no-folding --verbose --target="$HOME" tmux
    ln -s -f -v "$HOME/.tmux/paste-wsl.sh" "$HOME/.tmux/paste.sh"

    _stdout "Setting up alacritty"
		stow --no-folding --verbose --target="$HOME" alacritty
    ln -s -f -v "$HOME/.config/alacritty/alacritty-wsl.yml" "$HOME/.config/alacritty/alacritty.yml"
  };;
  linux-fedora*) {
    sudo dnf install -y stow

    wget -q -O "$HOME/.antigen.vendored.zsh" "https://raw.githubusercontent.com/zsh-users/antigen/develop/bin/antigen.zsh"  # TODO: dnf does not have an antigen package, so vendor it in manually
    mkdir -p "$HOME/.config/alacritty"
    mkdir "$HOME/.tmux" 2>/dev/null
    mkdir "$HOME/.zsh" 2>/dev/null
    if [ -f "$HOME/.zshrc" ]; then
      mv "$HOME/.zshrc" "$HOME/.old_zshrc"
    fi

    _stdout "Setting up zsh"
    stow --no-folding --verbose --target="$HOME" zsh
    _antigen_zsh="$HOME/.antigen.vendored.zsh"
    ln -s -f -v "$_antigen_zsh" "$HOME/.zsh/antigen.zsh"

    stow --no-folding --verbose --target="$HOME" vim

    stow --no-folding --verbose --target="$HOME" tmux
    sudo dnf install -y xsel
    ln -s -f -v "$HOME/.tmux/paste-linux.sh" "$HOME/.tmux/paste.sh"

    sudo dnf install -y alacritty
    stow --no-folding --verbose --target="$HOME" alacritty
    ln -s -f -v "$HOME/.config/alacritty/alacritty-linux.toml" "$HOME/.config/alacritty/alacritty.toml"
  };;
  *) {
    _error_with_message "Prerequisite setup not handled for OS: $_OS_TYPE"
  }
esac
_stdout "Done"

## Verify correct installation
_PREPEND="[verification]"
_stdout "Verifying environment install"

_has_failed_verification=0
_fail_verification() {
  _has_failed_verification=1
}

if ! [ -f "$HOME/.zsh/antigen.zsh" ]; then
  _stderr "zsh: antigen script missing"
  _fail_verification
fi
if ! [ -f "$HOME/.tmux/paste.sh" ]; then
  _stderr "tmux: paste script missing"
  _fail_verification
fi

if [ "$_has_failed_verification" != 0 ]; then
  _error_with_message "Verification failed"
else
  _stdout "Environment install verified"
fi

