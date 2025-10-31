#!/bin/bash
# Additional package installations (Python, Yarn, etc.)

source "$(dirname "$0")/common.sh"

install_python_packages() {
    print_info "Installing Python packages..."
    
    if command_exists pip || command_exists pip3; then
        ${PIP:-pip3} install --user pynvim
        print_success "Python packages installed"
    else
        print_warning "pip not found, skipping Python packages"
    fi
}

install_yarn_packages() {
    print_info "Installing Yarn packages..."
    
    if command_exists yarn; then
        yarn global add neovim
        print_success "Yarn packages installed"
    else
        print_warning "yarn not found, skipping Yarn packages"
    fi
}

install_zoxide() {
    print_info "Installing zoxide..."
    
    if ! command_exists zoxide; then
        curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
        print_success "zoxide installed"
    else
        print_success "zoxide already installed"
    fi
}

install_kitty() {
    print_info "Installing Kitty terminal..."
    
    if ! command_exists kitty; then
        curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin launch=n
        print_success "Kitty installed"
    else
        print_success "Kitty already installed"
    fi
}

install_nix() {
    local os=$(detect_os)
    
    if ! command_exists nix; then
        print_info "Installing Nix package manager..."
        
        if [[ "$os" == "linux" ]]; then
            sh <(curl -L https://nixos.org/nix/install) --no-daemon
        else
            sh <(curl -L https://nixos.org/nix/install)
        fi
        
        print_success "Nix installed"
    else
        print_success "Nix already installed"
    fi
}

# Run if executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_python_packages
    install_yarn_packages
    install_zoxide
    install_kitty
    install_nix
fi

