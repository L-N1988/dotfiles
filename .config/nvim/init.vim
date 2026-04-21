if exists('g:vscode')
    " VSCode extension configuration
    " =============================================================================
    " Fcitx5 Auto-Switch (Async & VS Code Optimized)
    " =============================================================================

    " 1. Global State Management
    let g:fcitx5state = '1' " Default to English/Inactive

    " 2. The Universal Async Handler
    function! Fcitx5JobHandler(job_id, data, event) dict
        if a:event == 'stdout'
            " Safely capture the current state (1 or 2)
            if len(a:data) > 0 && len(a:data[0]) > 0
                let self.temp_state = a:data[0][0]
            endif
        elseif a:event == 'exit'
            " If the command succeeded (exit code 0), update global state
            if a:data == 0
                let g:fcitx5state = self.temp_state
            else
                " If fcitx5 is dead/crashed, fallback to safe English state
                let g:fcitx5state = '1'
            endif

            " ALWAYS force English when leaving Insert or switching focus
            " This ensures Normal Mode is never stuck in Chinese
            call jobstart(['fcitx5-remote', '-c'])
        endif
    endfunction

    " 3. Autocommand Group
    augroup FcitxUniversalSync
        autocmd!

        " --- Terminal & VS Code Shared Logic ---
        " When leaving Insert Mode, record state and force English
        autocmd InsertLeave * call jobstart(['fcitx5-remote'], {
                    \ 'on_stdout': function('Fcitx5JobHandler'),
                    \ 'on_exit': function('Fcitx5JobHandler'),
                    \ 'stdout_buffered': v:true,
                    \ 'temp_state': '1'
                    \ })

        " When entering Insert Mode, restore Chinese only if it was active before
        autocmd InsertEnter * if g:fcitx5state == '2' | call jobstart(['fcitx5-remote', '-o']) | endif
    augroup END

else
    " ordinary Neovim
    set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath=&runtimepath
    source ~/.vimrc
endif
