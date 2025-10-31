#!/bin/bash
# Homebrew installation and package management

source "$(dirname "$0")/_installer/common.sh"

install_homebrew() {
    print_info "Checking for Homebrew..."

    if ! command_exists brew; then
        print_info "Homebrew not found, installing now..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        # Add Homebrew to PATH for this session
        source_brew_env

        print_success "Homebrew installed successfully!"
    else
        print_success "Homebrew already installed"
    fi
}

install_brew_packages() {
    print_info "Installing packages via Homebrew..."

    local packages=(
        neovim
        starship
        nushell
        btop
        ripgrep
        fd
        adr-tools
        bat
        yarn
        zoxide
        git-delta
    )

    brew install "${packages[@]}"

    print_success "Homebrew packages installed"
}

# Run if executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_homebrew
    install_brew_packages
fi

