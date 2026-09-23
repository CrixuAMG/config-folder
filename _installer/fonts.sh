#!/bin/bash
# Font installation script

source "$(dirname "$0")/_installer/common.sh"

install_fonts() {
    print_info "Installing FiraCode Nerd Font..."
    
    if [ ! -d "fonts" ]; then
        # Use HTTPS instead of SSH for better compatibility
        git clone --filter=blob:none --sparse https://github.com/ryanoasis/nerd-fonts fonts
        cd fonts
        git sparse-checkout add patched-fonts/FiraCode
        cd - > /dev/null

        # Run the font installer
        ./fonts/install.sh FiraCode

        print_success "FiraCode Nerd Font installed successfully!"
    else
        print_success "Fonts directory already exists, skipping font installation"
    fi
}

# Run if executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_fonts
fi

