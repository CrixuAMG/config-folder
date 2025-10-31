#!/bin/bash
# Configuration file setup

source "$(dirname "$0")/common.sh"

setup_config_files() {
    print_section "Setting up configuration files"
    
    # Copy Starship configuration
    if [ -f "$HOME/.config/starship.toml" ]; then
        cp "$HOME/.config/starship.toml" "$HOME/"
        print_success "Starship configuration copied"
    else
        print_warning "Starship config not found at ~/.config/starship.toml"
    fi
    
    # Create kitty sessions directory
    mkdir -p "$HOME/.config/kitty/sessions"
    print_success "Kitty sessions directory created"
}

# Run if executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    setup_config_files
fi

