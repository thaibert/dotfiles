#!/bin/sh

echo "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Installing oh-my-zsh"
/bin/sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing homebrew packages"
brew bundle install --no-lock 

echo "Stowing dotfiles into home directory ($(echo $HOME))"
/bin/sh stow.sh

