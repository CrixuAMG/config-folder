#!/bin/bash

echo "Installing configurations..."

echo "Installing TMUX plugin manager TPM"
rm -rf ~/.tmux/plugins/tpm && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 
echo "Installed"

echo "Copying TMUX configuration file"
cp $HOME/.config/tmux/.tmux.conf ~/
echo "Updated TMUX configuration"

echo "Copying Starship configuration file"
cp $HOME/.config/starship.toml ~/
echo "Updated Starship configuration"
