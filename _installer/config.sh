#!/bin/bash
# Configuration file setup

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
source "$SCRIPT_DIR/common.sh"

# Link a dotfile in $HOME to its source in this repository.
# Existing files are never overwritten silently: the difference is printed and
# replacing is only done after confirmation, with a timestamped backup.
link_config_file() {
    local source_file="$1"
    local link_path="$2"
    local label="${3:-$(basename "$link_path")}"

    if [ ! -f "$source_file" ]; then
        print_warning "$label: source not found at $source_file"
        return 0
    fi

    if [ -L "$link_path" ]; then
        local current_target
        current_target="$(readlink "$link_path")"
        if [ "$current_target" == "$source_file" ]; then
            print_success "$label already linked to $current_target"
            return 0
        fi
        print_info "$label currently points to $current_target"
    elif [ -e "$link_path" ]; then
        print_warning "$label exists in $HOME and is not a symlink"
        print_info "  diff: $HOME/$label (current) -> $source_file (repository)"
        diff -u "$link_path" "$source_file" | sed 's/^/  /' || true
        local answer=""
        read -r -p "  Replace it with a symlink? [y/N] " answer || answer=""
        case "$answer" in
            [yY]|[yY][eE][sS])
                local backup="${link_path}.bak-$(date +%Y%m%d%H%M%S)"
                mv "$link_path" "$backup"
                print_info "  backup created: $backup"
                ;;
            *)
                print_info "  $label left untouched"
                return 0
                ;;
        esac
    fi

    ln -sfn "$source_file" "$link_path"
    print_success "$label -> $source_file"
}

setup_config_files() {
    print_section "Setting up configuration files"

    # Dotfiles managed from this repository (symlinked into $HOME)
    link_config_file "$CONFIG_DIR/zsh/.zshrc" "$HOME/.zshrc" ".zshrc"
    link_config_file "$CONFIG_DIR/.gitconfig" "$HOME/.gitconfig" ".gitconfig"

    # The global gitignore needs no symlink: git reads ~/.config/git/ignore as
    # the default core.excludesFile. Verify it is actually picked up.
    if [ -f "$CONFIG_DIR/git/ignore" ]; then
        if git config --get core.excludesFile >/dev/null 2>&1; then
            print_warning "core.excludesFile is set explicitly, $CONFIG_DIR/git/ignore is not used"
        else
            print_success "Global gitignore active: $CONFIG_DIR/git/ignore"
        fi
    fi

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