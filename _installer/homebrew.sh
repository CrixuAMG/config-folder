#!/bin/bash
# Homebrew installation and package management

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

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
        "koekeishiya/formulae"
        "FelixKratz/formulae"
        "gammons/tap"
    )

    for tap in "${taps[@]}"; do
        if ! brew tap | grep -qix "$tap"; then
            brew tap "$tap"
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

    brew install --formula "$package"
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
        koekeishiya/formulae/yabai
        koekeishiya/formulae/skhd
        FelixKratz/formulae/sketchybar
        FelixKratz/formulae/borders
        opencode
        gammons/tap/slk
    )

    for package in "${packages[@]}"; do
        brew_install_formula "$package"
    done

    print_success "Homebrew packages installed"
}

install_brew_casks() {
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
    print_info "Restarting window manager services..."

    if command_exists yabai; then
        yabai --restart-service
        print_success "yabai restarted"
    else
        print_warning "yabai not found, skipping restart"
    fi

    if command_exists skhd; then
        skhd --restart-service
        print_success "skhd restarted"
    else
        print_warning "skhd not found, skipping restart"
    fi

    if command_exists sketchybar; then
        brew services restart sketchybar
        print_success "sketchybar restarted"
    else
        print_warning "sketchybar not found, skipping restart"
    fi

    if command_exists borders; then
        brew services restart borders
        print_success "borders restarted"
    else
        print_warning "borders not found, skipping restart"
    fi
}

# Run if executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_homebrew
    install_brew_packages
    install_brew_casks
    cleanup_brew
fi

