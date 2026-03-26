#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Backup existing files
backup_file() {
    local file=$1
    if [ -e "$file" ] && [ ! -L "$file" ]; then
        mkdir -p "$BACKUP_DIR"
        cp -r "$file" "$BACKUP_DIR/"
        log_warn "Backed up $file to $BACKUP_DIR"
    fi
}

# Create symlink
create_symlink() {
    local source=$1
    local target=$2
    
    backup_file "$target"
    
    # Remove existing symlink or directory
    if [ -L "$target" ]; then
        rm "$target"
    elif [ -d "$target" ] && [ ! "$target" -ef "$source" ]; then
        rm -rf "$target"
    fi
    
    # Create parent directory if it doesn't exist
    mkdir -p "$(dirname "$target")"
    
    # Create symlink
    ln -sf "$source" "$target"
    log_info "Linked $target -> $source"
}

# Main installation
main() {
    log_info "Starting dotfiles installation..."
    log_info "Dotfiles directory: $DOTFILES_DIR"
    
    # Install home directory configs
    log_info "Installing home directory configs..."
    create_symlink "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"
    create_symlink "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
    create_symlink "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
    create_symlink "$DOTFILES_DIR/.tmux.conf.local" "$HOME/.tmux.conf.local"
    create_symlink "$DOTFILES_DIR/.Xresources" "$HOME/.Xresources"
    create_symlink "$DOTFILES_DIR/.Xmodmap" "$HOME/.Xmodmap"
    create_symlink "$DOTFILES_DIR/.xinitrc" "$HOME/.xinitrc"
    create_symlink "$DOTFILES_DIR/.xprofile" "$HOME/.xprofile"
    create_symlink "$DOTFILES_DIR/.zprofile" "$HOME/.zprofile"
    create_symlink "$DOTFILES_DIR/.bash_profile" "$HOME/.bash_profile"
    create_symlink "$DOTFILES_DIR/deepin-terminal.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/deepin-terminal.zsh-theme"
    
    # Emacs configs
    create_symlink "$DOTFILES_DIR/tsoding-emacs/.emacs" "$HOME/.emacs"
    create_symlink "$DOTFILES_DIR/tsoding-emacs/.emacs.custom.el" "$HOME/.emacs.custom.el"
    create_symlink "$DOTFILES_DIR/tsoding-emacs/.emacs.local" "$HOME/.emacs.local"
    create_symlink "$DOTFILES_DIR/tsoding-emacs/.emacs.rc" "$HOME/.emacs.rc"
    create_symlink "$DOTFILES_DIR/tsoding-emacs/.emacs.snippets" "$HOME/.emacs.snippets"
    
    # Git configs
    create_symlink "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
    create_symlink "$DOTFILES_DIR/git/.gitconfig-zju" "$HOME/.gitconfig-zju"
    
    # Tmux
    mkdir -p "$HOME/.tmux"
    create_symlink "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux/.tmux.conf"
    
    # Config directory
    log_info "Installing .config files..."
    create_symlink "$DOTFILES_DIR/.config/kitty" "$HOME/.config/kitty"
    create_symlink "$DOTFILES_DIR/.config/alacritty" "$HOME/.config/alacritty"
    create_symlink "$DOTFILES_DIR/.config/neofetch" "$HOME/.config/neofetch"
    create_symlink "$DOTFILES_DIR/.config/bspwm" "$HOME/.config/bspwm"
    create_symlink "$DOTFILES_DIR/.config/dunst" "$HOME/.config/dunst"
    create_symlink "$DOTFILES_DIR/.config/picom" "$HOME/.config/picom"
    create_symlink "$DOTFILES_DIR/.config/polybar" "$HOME/.config/polybar"
    create_symlink "$DOTFILES_DIR/.config/rofi" "$HOME/.config/rofi"
    create_symlink "$DOTFILES_DIR/.config/sakura" "$HOME/.config/sakura"
    create_symlink "$DOTFILES_DIR/.config/sxhkd" "$HOME/.config/sxhkd"
    create_symlink "$DOTFILES_DIR/.config/zathura" "$HOME/.config/zathura"
    create_symlink "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"
    create_symlink "$DOTFILES_DIR/.config/fcitx" "$HOME/.config/fcitx"
    create_symlink "$DOTFILES_DIR/.config/fcitx5" "$HOME/.config/fcitx5"
    
    # Doom Emacs
    create_symlink "$DOTFILES_DIR/.config/doom" "$HOME/.config/doom"
    
    # Scripts
    create_symlink "$DOTFILES_DIR/.scripts" "$HOME/.scripts"
    
    # Vim UltiSnips
    create_symlink "$DOTFILES_DIR/UltiSnips" "$HOME/.vim/UltiSnips"
    
    # VSCode snippets
    create_symlink "$DOTFILES_DIR/VSCode" "$HOME/.config/Code/User/snippets"
    
    # IPython profile
    create_symlink "$DOTFILES_DIR/profile_default" "$HOME/.ipython/profile_default"
    
    # Zotero CSS
    create_symlink "$DOTFILES_DIR/zotero.css" "$HOME/.config/zotero/zotero.css"
    
    # Make bspwmrc executable
    chmod +x "$HOME/.config/bspwm/bspwmrc"
    chmod +x "$HOME/.config/polybar/launch.sh"
    
    # Make scripts executable
    find "$HOME/.scripts" -type f -name "*.sh" -exec chmod +x {} \;
    
    log_info "Installation complete!"
    if [ -d "$BACKUP_DIR" ]; then
        log_info "Backed up files are in: $BACKUP_DIR"
    fi
    log_info "Please restart your shell or run 'source ~/.bashrc' (or ~/.zshrc) to apply changes."
}

main