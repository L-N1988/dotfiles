#!/bin/bash

ln -f ~/.vimrc .vimrc
ln -f ~/.bashrc .bashrc
ln -f ~/.zshrc .zshrc
cp ~/.tmux/.tmux.conf .tmux.conf
cp -r ~/.scripts/ .
ln -f ~/.tmux.conf.local .tmux.conf.local
ln -f ~/.Xresources .Xresources
ln -f ~/.Xmodmap .Xmodmap

ln -f ~/.config/alacritty/alacritty.yml .config/alacritty/alacritty.yml 
ln -f ~/.config/alacritty/catppuccin-mocha.yml .config/alacritty/catppuccin-mocha.yml
ln -f ~/.config/bspwm/bspwmrc .config/bspwm/bspwmrc
ln -f ~/.config/dunst/dunstrc .config/dunst/dunstrc
ln -f ~/.config/picom/picom.conf .config/picom/picom.conf
ln -f ~/.config/polybar/config.ini .config/polybar/config.ini
ln -f ~/.config/rofi/config.rasi .config/rofi/config.rasi
ln -f ~/.config/rofi/power.rasi .config/rofi/power.rasi
ln -f ~/.config/sakura/sakura.conf .config/sakura/sakura.conf
ln -f ~/.config/sxhkd/sxhkdrc .config/sxhkd/sxhkdrc
ln -f ~/.config/zathura/zathurarc .config/zathura/zathurarc

cp -r ~/.config/fcitx/* .config/fcitx/
cp -r ~/.config/fcitx5/* .config/fcitx5/
cp -r ~/.ipython/profile_default/ .

# curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
#    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
