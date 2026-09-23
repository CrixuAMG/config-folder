#!/bin/bash
# Additional package installations

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

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

# Run if executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_yarn_packages
    install_zoxide
    install_kitty
fi

