if exists('g:vscode')
    " VSCode extension configuration
    " Default to safe state
    let g:fcitx5state = '1'

    " The async handler function
    function! Fcitx5JobHandler(job_id, data, event) dict
        if a:event == 'stdout'
            " Safely check if output is valid and not empty
            if len(a:data) > 0 && len(a:data[0]) > 0
                let self.temp_state = a:data[0][0]
            endif
        elseif a:event == 'exit'
            " a:data contains the exit code on the 'exit' event
            if a:data == 0
                let g:fcitx5state = self.temp_state
                if g:fcitx5state == '2'
                    call jobstart(['fcitx5-remote', '-c'])
                endif
            else
                " Command failed (fcitx5 dead), fallback to safe state
                let g:fcitx5state = '1'
            endif
        endif
    endfunction

    augroup FcitxAsyncSafe
        autocmd!
        autocmd InsertLeave * call jobstart(['fcitx5-remote'], {
                    \ 'on_stdout': function('Fcitx5JobHandler'),
                    \ 'on_exit': function('Fcitx5JobHandler'),
                    \ 'stdout_buffered': v:true,
                    \ 'temp_state': '1'
                    \ })
        autocmd InsertEnter * if g:fcitx5state == '2' | call jobstart(['fcitx5-remote', '-o']) | endif
    augroup END
else
    " ordinary Neovim
    set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath=&runtimepath
    source ~/.vimrc
endif
