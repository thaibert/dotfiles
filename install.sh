#!/bin/sh
# TODO: parameterise over OS type to get packages correctly

echo "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Installing homebrew packages"
brew bundle install --no-lock 

echo "Stowing dotfiles into home directory ($(echo $HOME))"
/bin/sh stow.sh

echo "Linking antigen into zsh folder"
ln --symbolic /usr/share/local/antigen/antigen.zsh $ZSH/antigen.zsh  # macOS
# ln --symbolic /usr/share/antigen/antigen.zsh $ZSH/antigen.zsh  # debian

