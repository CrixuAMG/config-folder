#!/bin/bash
# Homebrew installation and package management

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

OS=$(detect_os)

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

tap_brew_repos() {
    print_info "Tapping required Homebrew repositories..."

    local taps=(
        "gammons/tap"
    )

    for tap in "${taps[@]}"; do
        if ! brew tap | grep -qix "$tap"; then
            brew tap --quiet "$tap" || brew tap "$tap"
            print_success "Tapped $tap"
        else
            print_info "$tap already tapped"
        fi

        brew trust "$tap" 2>/dev/null || true
    done
}

brew_install_formula() {
    local package="$1"

    # Extract the short formula name for installed checks
    local formula_name
    formula_name="$(basename "$package")"

    if brew list --formula "$formula_name" &>/dev/null; then
        print_info "$formula_name already installed, skipping"
        return 0
    fi

    HOMEBREW_NO_AUTO_UPDATE=1 brew install --formula --yes "$package"
}

install_brew_packages() {
    print_info "Installing packages via Homebrew..."

    # Make sure the required third-party taps are available
    tap_brew_repos

    local packages=(
        neovim
        starship
        atuin
        nushell
        btop
        ripgrep
        fd
        adr-tools
        bat
        yarn
        zoxide
        git-delta
        jq
        tree
        tree-sitter
        tree-sitter-cli
        lazygit
        opencode
        gammons/tap/slk
    )

    for package in "${packages[@]}"; do
        brew_install_formula "$package"
    done

    print_success "Homebrew packages installed"
}

install_brew_casks() {
    if [[ "$OS" != "macos" ]]; then
        print_info "Skipping cask installation on Linux"
        return
    fi

    print_info "Installing casks via Homebrew..."

    local casks=(
        bartender
    )

    brew install --cask "${casks[@]}"

    print_success "Homebrew casks installed"
}

cleanup_brew() {
    print_info "Cleaning up Homebrew..."
    brew cleanup
    print_success "Homebrew cleaned up"
}

restart_window_manager_services() {
    if [[ "$OS" != "macos" ]]; then
        print_info "Skipping window manager restart on Linux"
        return
    fi

    print_info "Restarting window manager services..."
}

# Run if executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_homebrew
    install_brew_packages
    install_brew_casks
    cleanup_brew
fi

