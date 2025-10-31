#!/bin/bash
# macOS-specific setup and configuration

source "$(dirname "$0")/common.sh"

install_macos_casks() {
    print_info "Installing macOS casks..."
    
    local casks=(
        alt-tab
    )
    
    brew install --cask "${casks[@]}"
    
    print_success "macOS casks installed"
}

setup_lazygit_macos() {
    print_info "Setting up Lazygit..."
    
    # Install lazygit
    brew install lazygit
    
    # Copy lazygit config
    if [ -f ~/.config/lazygit/config.yml ]; then
        mkdir -p ~/Library/Application\ Support/lazygit
        cp ~/.config/lazygit/config.yml ~/Library/Application\ Support/lazygit/config.yml
        print_success "Lazygit configuration copied"
    else
        print_warning "Lazygit config not found at ~/.config/lazygit/config.yml"
    fi
}

setup_macos_specific() {
    print_section "macOS-Specific Setup"
    
    # Install casks
    install_macos_casks
    
    # Setup Lazygit
    setup_lazygit_macos
    
    # Install Nix
    if ! command_exists nix; then
        print_info "Installing Nix package manager..."
        sh <(curl -L https://nixos.org/nix/install)
        print_success "Nix installed"
    else
        print_success "Nix already installed"
    fi
}

# Run if executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    setup_macos_specific
fi

