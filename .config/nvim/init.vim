if exists('g:vscode')
    " VSCode extension
    " state = 1, inactive mode for en input; state = 2, active mode for zh input
    " -c		inactivate input method
    " -o		activate input method
    let g:fcitx5state = system("fcitx5-remote")[0]

    augroup FcitxSync
        autocmd!
        autocmd InsertLeave * let g:fcitx5state = system("fcitx5-remote")[0] | call system("fcitx5-remote -c")
        autocmd InsertEnter * if g:fcitx5state == '2' | call system("fcitx5-remote -o") | endif
    augroup END
else
    " ordinary Neovim
    set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath=&runtimepath
    source ~/.vimrc
endif
