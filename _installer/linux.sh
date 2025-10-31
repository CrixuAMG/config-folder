#!/bin/bash
# Linux-specific setup and configuration

source "$(dirname "$0")/common.sh"

setup_kitty_linux() {
    print_info "Setting up Kitty for Linux..."
    
    # Create ~/.local/bin if it doesn't exist
    mkdir -p ~/.local/bin
    
    # Create symbolic links for kitty and kitten
    ln -sf ~/.local/kitty.app/bin/kitty ~/.local/bin/
    ln -sf ~/.local/kitty.app/bin/kitten ~/.local/bin/
    
    # Set up desktop integration
    mkdir -p ~/.local/share/applications
    
    if [ -f ~/.local/kitty.app/share/applications/kitty.desktop ]; then
        cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
        cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
        
        # Update paths in kitty.desktop files
        sed -i "s|Icon=kitty|Icon=$HOME/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
        sed -i "s|Exec=kitty|Exec=$HOME/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
        
        print_success "Kitty desktop integration configured"
    fi
    
    print_success "Kitty Linux setup complete"
}

setup_linux_specific() {
    print_section "Linux-Specific Setup"
    
    # Setup Kitty
    setup_kitty_linux
    
    # Install Nix
    if ! command_exists nix; then
        print_info "Installing Nix package manager..."
        sh <(curl -L https://nixos.org/nix/install) --no-daemon
        print_success "Nix installed"
    else
        print_success "Nix already installed"
    fi
}

# Run if executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    setup_linux_specific
fi

