" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Vim will load $VIMRUNTIME/defaults.vim if the user does not have a vimrc.
" This happens after /etc/vim/vimrc(.local) are loaded, so it will override
" any settings in these files.
" If you don't want that to happen, uncomment the below line to prevent
" defaults.vim from being loaded.
" let g:skip_defaults_vim = 1

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		    " Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
" set autowrite		" Automatically save before commands like :next and :make
" set hidden		" Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)
set foldmethod=manual

" Replace the tab to 4 space.
set ts=4
set expandtab
%retab!

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

set nu
set relativenumber
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set cindent
set ruler
set nobackup
set nocompatible
set backspace=indent,eol,start
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set rtp+=~/current_course
set scrolloff=5
set hlsearch
vnoremap . :norm.<CR
" use the spell check
" set spell spelllang=en_us

set wildmenu
set wildmode=longest:list,full

" https://blog.csdn.net/qq_41961459/article/details/104248701
map <C-A> ggvG$"+y
autocmd FileType tex source ~/.vim/tex.vimrc

call plug#begin('~/.vim/plugged')
Plug 'lervag/vimtex'
let g:tex_flavor='latex'
"使vimtex默认xelatex为编译器
let g:vimtex_compiler_latexmk_engines = {'_':'-xelatex'}

let g:vimtex_compiler_latexrun_engines ={'_':'xelatex'}
let g:vimtex_view_method='zathura'
""An alternative pdf reader: evince
" let g:vimtex_view_general_viewer='evince'
let g:vimtex_quickfix_mode=0
let g:vimtex_fold_enabled=0
set conceallevel=1
let g:tex_conceal='abdmg'
inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>
Plug 'Konfekt/FastFold'
nmap zuz <Plug>(FastFoldUpdate)
let g:fastfold_savehook = 1
let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']
let g:markdown_folding = 1
let g:rst_fold_enabled = 1
let g:tex_fold_enabled = 1
let g:vimsyn_folding = 'af'
let g:xml_syntax_folding = 1
let g:javaScript_fold = 1
let g:sh_fold_enabled= 7
let g:zsh_fold_enable = 1
let g:ruby_fold = 1
let g:perl_fold = 1
let g:perl_fold_blocks = 1
let g:r_syntax_folding = 1
let g:rust_fold = 1
let g:php_folding = 1
let g:fortran_fold=1
let g:clojure_fold = 1
let g:baan_fold=1
""folds are only updated manually but not when saving the buffer
let g:fastfold_savehook = 0
""folds are not updated whenever you close or open folds 
""by a standard keystroke such as zx,zo or zc
" let g:fastfold_fold_command_suffixes = []
""FastFold is by default enabled for files that 
""have more than a certain number of lines, default is 200
let g:fastfold_minlines = 100
xnoremap <silent> iz :<c-u>FastFoldUpdate<cr>]z<up>$v[z<down>^
xnoremap <silent> az :<c-u>FastFoldUpdate<cr>]zV[z
autocmd FileType c,cpp,java setlocal foldmethod=syntax
autocmd FileType python setlocal foldmethod=indent
Plug 'sirver/ultisnips'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsSnippetDirectories=["UltiSnips","mysnippets"]
Plug 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc','&completefunc']
let g:SuperTabRetainCompletionType=2
" configuration of the supertab 
inoremap <expr><Enter>  pumvisible() ? "\<C-Y>" : "\<Enter>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
Plug 'JuliaEditorSupport/julia-vim'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
" don't show the help in normal mode
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
" disable popup mode
" let g:Lf_WindowPosition = 'popup'
" let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }
let g:Lf_ShortcutF = "<leader>ff"
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
" noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
" search word under cursor literally only in current buffer
noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
" search word under cursor, the pattern is treated as regex, and enter normal mode directly
noremap <C-S> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
" search visually selected text literally
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
" recall last search. If the result window is closed, reopen it.
noremap go :<C-U>Leaderf! rg --recall<CR>
call plug#end()

" After viewing the video: 
" How to Do 90% of What Plugins Do (With Just Vim)
"
" Search down into subfolders
" Provide tab-completion for all file-related tasks 
set path+=.,**
" Display all matching files when we tab complete
set wildmenu
" :b lets you autocomplete any open buffer (aka any file has been opened by
" this vim)
" Use the :ls command to show files in the buffer
"
" ctags function
" Make tags: !ctags -R .
" Use Ctrl-] to jump to tag under cursor
" Ctrl-t to jump back
" g-Ctrl-] for ambiguous tags search
"
" autocomplete
" Ctrl-x-Ctrl-n JUST this file
" Ctrl-x-Ctrl-f for filenames (works with our path trick!)
" Ctrl-x-Ctrl-] for tags only
" Ctrl-n for anything specified by the 'complete' option 
"
" Tweaks for browsing
let g:netrw_banner = 0		" disable annoying banner
let g:netrw_liststyle=3		" tree view
"
" Source the termdebug plugin
packadd termdebug
" Add mapping to load termdebug
noremap <silent> <leader>td :Termdebug<CR><c-w>j<c-w>q<c-w>J<c-w>K<c-w>ja
" let g:termdebug_popup = 0
" let g:termdebug_wide = 100
"
" windows manage
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" windows size manage
nnoremap <silent> <Leader>= :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
