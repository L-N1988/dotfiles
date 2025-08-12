#!/bin/bash

ln -f ~/.vimrc .vimrc
ln -f ~/.bashrc .bashrc
ln -f ~/.zshrc .zshrc
ln -f ~/.tmux.conf.local .tmux.conf.local
ln -f ~/.Xresources .Xresources
ln -f ~/.Xmodmap .Xmodmap
ln -f ~/.emacs ./tsoding-emacs/.emacs
ln -f ~/.emacs.custom.el ./tsoding-emacs/.emacs.custom.el
ln -f ~/.tmux/.tmux.conf .tmux.conf
ln -f ~/.gitconfig ./git/.gitconfig
ln -f ~/.gitconfig-zju ./git/.gitconfig-zju

ln -f ~/.config/alacritty/alacritty.toml .config/alacritty/alacritty.toml 
ln -f ~/.config/bspwm/bspwmrc .config/bspwm/bspwmrc
ln -f ~/.config/dunst/dunstrc .config/dunst/dunstrc
ln -f ~/.config/picom/picom.conf .config/picom/picom.conf
ln -f ~/.config/polybar/config.ini .config/polybar/config.ini
ln -f ~/.config/polybar/launch.sh .config/polybar/launch.sh
cp -r ~/.config/polybar/themes/ .config/polybar/
ln -f ~/.config/rofi/config.rasi .config/rofi/config.rasi
ln -f ~/.config/rofi/power.rasi .config/rofi/power.rasi
ln -f ~/.config/sakura/sakura.conf .config/sakura/sakura.conf
ln -f ~/.config/sxhkd/sxhkdrc .config/sxhkd/sxhkdrc
ln -f ~/.config/zathura/zathurarc .config/zathura/zathurarc
cp -r ~/.config/zathura/themes/ .config/zathura/
ln -f ~/.config/doom/config.el .config/doom/config.el
ln -f ~/.config/doom/packages.el .config/doom/packages.el
ln -f ~/.config/doom/init.el .config/doom/init.el
ln -f ~/.config/doom/custom.el .config/doom/custom.el

# hard link not allowed for directory
cp -r ~/.emacs.local/ ./tsoding-emacs/.emacs.local/
cp -r ~/.emacs.rc/ ./tsoding-emacs/.emacs.rc/
cp -r ~/.emacs.snippets/ ./tsoding-emacs/.emacs.snippets/
cp -r ~/.scripts/ .
cp -r ~/.config/fcitx/* .config/fcitx/
cp -r ~/.config/fcitx5/* .config/fcitx5/
cp -r ~/.ipython/profile_default/ .
cp -r ~/.vim/UltiSnips/ .

# curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
#    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
