#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
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

log_file() {
    echo -e "${BLUE}  →${NC} $1"
}

echo ""
log_info "=== Dotfiles Installation Check ==="
echo ""

# Check if files exist and their status
check_file() {
    local source=$1
    local target=$2
    local target_name=$(basename "$target")
    
    if [ -L "$target" ]; then
        local link_target=$(readlink "$target")
        if [ "$link_target" = "$source" ]; then
            echo -e "${GREEN}✓${NC} $target_name ${GREEN}(linked)${NC}"
        else
            echo -e "${YELLOW}◍${NC} $target_name ${YELLOW}(linked to different target: $link_target)${NC}"
        fi
    elif [ -e "$target" ]; then
        echo -e "${YELLOW}◍${NC} $target_name ${YELLOW}(exists, will be backed up)${NC}"
    else
        echo -e "${BLUE}○${NC} $target_name ${BLUE}(will be created)${NC}"
    fi
}

log_info "Home directory files:"
check_file "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"
check_file "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
check_file "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
check_file "$DOTFILES_DIR/.tmux.conf.local" "$HOME/.tmux.conf.local"
check_file "$DOTFILES_DIR/.Xresources" "$HOME/.Xresources"
check_file "$DOTFILES_DIR/.Xmodmap" "$HOME/.Xmodmap"
check_file "$DOTFILES_DIR/.xinitrc" "$HOME/.xinitrc"
check_file "$DOTFILES_DIR/.xprofile" "$HOME/.xprofile"
check_file "$DOTFILES_DIR/.zprofile" "$HOME/.zprofile"
check_file "$DOTFILES_DIR/.bash_profile" "$HOME/.bash_profile"

echo ""
log_info "Emacs configurations:"
check_file "$DOTFILES_DIR/tsoding-emacs/.emacs" "$HOME/.emacs"
check_file "$DOTFILES_DIR/tsoding-emacs/.emacs.custom.el" "$HOME/.emacs.custom.el"
check_file "$DOTFILES_DIR/tsoding-emacs/.emacs.local" "$HOME/.emacs.local"
check_file "$DOTFILES_DIR/tsoding-emacs/.emacs.rc" "$HOME/.emacs.rc"
check_file "$DOTFILES_DIR/tsoding-emacs/.emacs.snippets" "$HOME/.emacs.snippets"

echo ""
log_info "Git configurations:"
check_file "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
check_file "$DOTFILES_DIR/git/.gitconfig-zju" "$HOME/.gitconfig-zju"

echo ""
log_info "Tmux:"
check_file "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux/.tmux.conf"

echo ""
log_info ".config files:"
check_file "$DOTFILES_DIR/.config/kitty" "$HOME/.config/kitty"
check_file "$DOTFILES_DIR/.config/alacritty" "$HOME/.config/alacritty"
check_file "$DOTFILES_DIR/.config/neofetch" "$HOME/.config/neofetch"
check_file "$DOTFILES_DIR/.config/bspwm" "$HOME/.config/bspwm"
check_file "$DOTFILES_DIR/.config/dunst" "$HOME/.config/dunst"
check_file "$DOTFILES_DIR/.config/picom" "$HOME/.config/picom"
check_file "$DOTFILES_DIR/.config/polybar" "$HOME/.config/polybar"
check_file "$DOTFILES_DIR/.config/rofi" "$HOME/.config/rofi"
check_file "$DOTFILES_DIR/.config/sakura" "$HOME/.config/sakura"
check_file "$DOTFILES_DIR/.config/sxhkd" "$HOME/.config/sxhkd"
check_file "$DOTFILES_DIR/.config/zathura" "$HOME/.config/zathura"
check_file "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"
check_file "$DOTFILES_DIR/.config/fcitx" "$HOME/.config/fcitx"
check_file "$DOTFILES_DIR/.config/fcitx5" "$HOME/.config/fcitx5"
check_file "$DOTFILES_DIR/.config/doom" "$HOME/.config/doom"

echo ""
log_info "Other:"
check_file "$DOTFILES_DIR/.scripts" "$HOME/.scripts"
check_file "$DOTFILES_DIR/UltiSnips" "$HOME/.vim/UltiSnips"
check_file "$DOTFILES_DIR/VSCode" "$HOME/.config/Code/User/snippets"
check_file "$DOTFILES_DIR/profile_default" "$HOME/.ipython/profile_default"
check_file "$DOTFILES_DIR/zotero.css" "$HOME/.config/zotero/zotero.css"

echo ""
log_info "Legend:"
echo -e "  ${GREEN}✓${NC} Already correctly linked"
echo -e "  ${YELLOW}◍${NC} Exists but needs attention (will be backed up)"
echo -e "  ${BLUE}○${NC} Will be created"
echo ""
log_info "To install, run: ./install.sh"
log_info "For full installation (with packages), run: ./full-install.sh"
echo ""