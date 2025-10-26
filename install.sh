#!/bin/bash
set -e  # Exit on error

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALLER_DIR="$SCRIPT_DIR/_installer"

# Source common utilities
source "$INSTALLER_DIR/common.sh"

# Print banner
print_section "Development Environment Installer"
print_info "This script will install and configure your development environment"
print_info "Detected OS: $(detect_os)"
echo ""

# Detect OS
OS=$(detect_os)

if [[ "$OS" == "unknown" ]]; then
    print_error "Unsupported operating system"
    exit 1
fi

# Install fonts
echo ""
source "$INSTALLER_DIR/fonts.sh"
install_fonts

# Install Homebrew
echo ""
source "$INSTALLER_DIR/homebrew.sh"
install_homebrew
install_brew_packages

# Install additional packages
echo ""
source "$INSTALLER_DIR/packages.sh"
install_python_packages
echo ""
install_yarn_packages
echo ""
install_zoxide
echo ""
install_kitty

# Platform-specific setup
echo ""
if [[ "$OS" == "linux" ]]; then
    source "$INSTALLER_DIR/linux.sh"
    setup_linux_specific
elif [[ "$OS" == "macos" ]]; then
    source "$INSTALLER_DIR/macos.sh"
    setup_macos_specific
fi

# Setup configuration files
echo ""
source "$INSTALLER_DIR/config.sh"
setup_config_files

# Final message
print_section "Installation Complete!"
echo ""
print_info "Next steps:"
print_info "1. Restart your terminal or run: exec \$SHELL"
print_info "2. If using kitty for the first time, restart it to apply the configuration"
print_info "3. Run 'nu' to start Nushell"
echo ""
