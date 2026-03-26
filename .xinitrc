#!/bin/zsh -l
# The -l flag tells zsh to act as a login shell, 
# which forces it to source ~/.zprofile
# Force the environment to load as a login shell
if [ -f ~/.bash_profile ]; then
    . ~/.bash_profile
fi

export XDG_SESSION_TYPE=x11
exec bspwm
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
# If using X11/bspwm, you can set your WM variables here
export XDG_CONFIG_HOME="$HOME/.config"
$HOME/.scripts/floatDesktop.sh
