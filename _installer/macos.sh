#!/bin/bash
# macOS-specific setup and configuration

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

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

    # Setup Lazygit
    setup_lazygit_macos
}

# Run if executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    setup_macos_specific
fi

