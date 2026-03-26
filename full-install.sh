#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    log_error "Please run as regular user, not root"
    exit 1
fi

# Check if sudo is available
if ! command -v sudo &> /dev/null; then
    log_error "sudo is not installed. Please install sudo first."
    exit 1
fi

log_info "=== Full Dotfiles Installation ==="
log_info "This will:"
log_info "  1. Update system packages"
log_info "  2. Install required packages from packages.txt"
log_info "  3. Run the dotfiles installation script"
echo ""

read -p "Continue? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    log_info "Installation cancelled"
    exit 0
fi

# Step 1: Update system
log_info "Step 1/3: Updating system..."
sudo pacman -Syu --noconfirm

# Step 2: Install packages
log_info "Step 2/3: Installing packages..."
if [ -f "$DOTFILES_DIR/packages.txt" ]; then
    # Filter out comments and empty lines, then install
    grep -v "^#" "$DOTFILES_DIR/packages.txt" | grep -v "^$" | xargs sudo pacman -S --needed --noconfirm
    log_info "Packages installed successfully"
else
    log_warn "packages.txt not found, skipping package installation"
fi

# Step 3: Run dotfiles installation
log_info "Step 3/3: Installing dotfiles..."
"$DOTFILES_DIR/install.sh"

log_info ""
log_info "=== Installation Complete ==="
log_info ""
log_info "Next steps:"
log_info "  1. Restart your shell or run: source ~/.bashrc (or ~/.zshrc)"
log_info "  2. Install Doom Emacs: ~/.emacs.d/bin/doom install"
log_info "  3. Install vim plugins: Open nvim and run :PlugInstall"
log_info "  4. Start BSPWM: startx"
log_info ""