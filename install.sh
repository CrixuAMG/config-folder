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

brew tap homebrew/cask-fonts 
brew install neovim starship fish btop ripgrep fd adr-tools bat tlrc thefuck ranger

# Install zoxide (cd replacement)
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | fish

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin \
    launch=n

# Check if the OS is Linux
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "Setting up symbolic links for Linux..."
    # Create symbolic links for kitty and kitten
    ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/

    # Copy the kitty.desktop file
    cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/

    # If needed, add the kitty-open.desktop file
    cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/

    # Update paths in kitty.desktop files
    sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
    sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
    echo "Done!"
fi

echo "Copying Starship configuration file"
cp "$HOME/.config/starship.toml" "$HOME/"
echo "Updated Starship configuration"

if [[ "$(uname)" == "Darwin" ]]; then
    echo "Copying Lazygit configuration file"
    cp ~/.config/lazygit/config.yml ~/Library/Application\ Support/lazygit/config.yml

    echo "Installing nix..."
    sh <(curl -L https://nixos.org/nix/install)
    echo "Installed nix"

    brew install lazygit
else
    echo "Installing nix..."
    sh <(curl -L https://nixos.org/nix/install) --no-daemon
    echo "Installed nix"
fi

