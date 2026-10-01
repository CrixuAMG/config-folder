#!/bin/bash
# Font installation script

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
source "$SCRIPT_DIR/common.sh"

FONT_NAME="FiraCode"
NERD_FONTS_DIR="$CONFIG_DIR/fonts"
NERD_FONTS_INSTALLER="$NERD_FONTS_DIR/install.sh"

# Fetch the Nerd Fonts installer (relative to this repo, not to the caller's cwd)
clone_nerd_fonts() {
    print_info "Cloning Nerd Fonts into $NERD_FONTS_DIR"
    git clone --filter=blob:none --sparse https://github.com/ryanoasis/nerd-fonts "$NERD_FONTS_DIR" || return 1
    git -C "$NERD_FONTS_DIR" sparse-checkout add "patched-fonts/$FONT_NAME"
}

# Check the font directories the Nerd Fonts installer writes to on macOS and Linux
font_installed() {
    local dir
    for dir in "$HOME/Library/Fonts/NerdFonts" "$HOME/.local/share/fonts/NerdFonts"; do
        if compgen -G "$dir/${FONT_NAME}NerdFont*.ttf" > /dev/null; then
            return 0
        fi
    done
    return 1
}

install_fonts() {
    print_info "Installing $FONT_NAME Nerd Font..."

    if font_installed; then
        print_success "$FONT_NAME Nerd Font already installed"
        return 0
    fi

    if [ ! -f "$NERD_FONTS_INSTALLER" ]; then
        if ! clone_nerd_fonts; then
            print_warning "Could not fetch the Nerd Fonts installer, skipping font installation"
            return 0
        fi
    fi

    # The installer takes subcommands, e.g. "install FiraCode"
    if bash "$NERD_FONTS_INSTALLER" install "$FONT_NAME"; then
        print_success "$FONT_NAME Nerd Font installed"
    else
        print_warning "$FONT_NAME Nerd Font installation failed"
    fi
}

# Run if executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_fonts
fi