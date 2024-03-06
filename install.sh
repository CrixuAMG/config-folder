#!/bin/bash

echo "Looking for brew..."
if ! command -v brew &> /dev/null
then
    echo "Brew was not found, installing now..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    exit 1
else
    echo "Found brew"
fi

brew install --cask kitty
brew install neovim zoxide atuin starship zsh btop ripgrep fd adr-tools

echo "Installing nix..."
sh <(curl -L https://nixos.org/nix/install) --no-daemon
echo "Installed nix"

echo "Installing configurations..."

echo "Copying .zshrc"
cp $HOME/.config/.zshrc $HOME/.zshrc
source $HOME/.zshrc

echo "Copying Starship configuration file"
cp $HOME/.config/starship.toml ~/
echo "Updated Starship configuration"
