# Arch Linux Dotfiles

Personal dotfiles configuration for Arch Linux using BSPWM window manager.

## Features

- **Window Manager**: BSPWM with sxhkd
- **Terminal**: Kitty and Alacritty with Catppuccin themes
- **Bar**: Polybar with Catppuccin themes
- **Compositor**: Picom
- **Launcher**: Rofi
- **Notifications**: Dunst
- **Editor**: Neovim and Doom Emacs
- **Input**: Fcitx5 (Chinese input)

## Installation

### 1. Clone the repository

```bash
git clone https://github.com/L-N1988/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. Install required packages

```bash
# Install packages from official repositories
sudo pacman -S --needed - < packages.txt

# Or install interactively
sudo pacman -S bspwm sxhkd picom polybar rofi dunst kitty alacritty neovim emacs fcitx5 fcitx5-im fcitx5-chinese-addons zathura
```

### 3. Run the installation script

```bash
chmod +x install.sh
./install.sh
```

This will:
- Create symlinks for all configuration files
- Back up any existing configurations to `~/.dotfiles_backup_TIMESTAMP`
- Set proper permissions for scripts

### 4. Restart your shell

```bash
# For bash
source ~/.bashrc

# For zsh
source ~/.zshrc
```

### 5. Start BSPWM

```bash
startx
```

## Post-Installation Steps

### Doom Emacs

```bash
~/.emacs.d/bin/doom install
~/.emacs.d/bin/doom sync
```

### Neovim

Install vim-plug:
```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Then open Neovim and run:
```
:PlugInstall
```

### Python packages

```bash
pip install --user pynvim black flake8 pytest
```

## Directory Structure

```
dotfiles/
├── .config/           # Application configurations
│   ├── bspwm/        # BSPWM window manager
│   ├── polybar/      # Status bar
│   ├── rofi/         # Application launcher
│   ├── kitty/        # Terminal emulator
│   ├── alacritty/    # Alternative terminal
│   ├── nvim/         # Neovim config
│   ├── doom/         # Doom Emacs config
│   └── ...
├── .scripts/          # Utility scripts
├── UltiSnips/        # Vim snippets
├── tsoding-emacs/    # Emacs custom configs
└── git/              # Git configurations
```

## Custom Scripts

Located in `~/.scripts/`:

- `switchMonitor.sh` - Monitor configuration
- `floatDesktop.sh` - Floating window management
- `ocr.sh` - OCR functionality
- `pix2tex.sh` - Image to LaTeX
- And more...

## Maintenance

### Sync changes from home to dotfiles

```bash
./sync.sh
```

This backs up your current configurations to the repository.

### Update dotfiles from remote

```bash
git pull origin main
./install.sh
```

## Key Features

### BSPWM Rules

- Emacs opens on desktop 2
- Obsidian on desktop 5
- Gimp/Inkscape on desktop 7
- GeoGebra on desktop 9
- URxvt floating windows

### Theme

Uses Catppuccin color scheme across all applications:
- Border colors for windows
- Polybar theming
- Terminal colors
- Rofi styling

### Input Method

Fcitx5 with Chinese input support, automatically started with X session.

## Troubleshooting

If something doesn't work after installation:

1. Check if the symlink exists: `ls -la ~/.config/appname`
2. Check file permissions: `chmod +x ~/.config/bspwm/bspwmrc`
3. Review backup files in `~/.dotfiles_backup_*`
4. Check BSPWM logs: `~/.local/share/bspwm/bspwm.log`

## License

MIT