" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

" If you prefer the old-style vim functionalty, add 'runtime! vimrc_example.vim'
" Or better yet, read /usr/share/vim/vim80/vimrc_example.vim or the vim manual
" and configure vim to your own liking!

" do not load defaults if ~/.vimrc is missing
"let skip_defaults_vim=1

syntax on
" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark
" if strftime("%H") > 8 && strftime("%H") < 18
" 	set background=light
" else
" 	set background=dark
" endif

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
filetype plugin indent on

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd                    " Show (partial) command in status line.
set showmatch                  " Show matching brackets.
set ignorecase                 " Do case insensitive matching
set smartcase                  " Do smart case matching
set incsearch                  " Incremental search
set autowrite                  " Automatically save before commands like :next and :make
set hidden                     " Hide buffers when they are abandoned
set mouse=a                    " Enable mouse usage (all modes)

setlocal noswapfile            " 不要生成swap文件
set bufhidden=hide             " 当buffer被丢弃的时候隐藏它
set number                     " 显示行号
set relativenumber
set cursorline
set ruler                      " 打开状态栏标尺
set shiftwidth=4               " 设定 << 和 >> 命令移动时的宽度为 4
set softtabstop=4              " 使得按退格键时可以一次删掉 4 个空格
set tabstop=4                  " 设定 tab 长度为 4
set expandtab                  " tab缩进替换相同数量的空格
set nobackup                   " 覆盖文件时不备份
                               " set autochdir                  " 自动切换当前目录为当前文件所在的目录pwd current dir
set backupcopy=yes             " 设置备份时的行为为覆盖
set hlsearch                   " 搜索时高亮显示被找到的文本
set noerrorbells               " 关闭错误信息响铃
set novisualbell               " 关闭使用可视响铃代替呼叫
set t_vb=                      " 置空错误铃声的终端代码
set matchtime=2                " 短暂跳转到匹配括号的时间
set magic                      " 设置魔术
set smartindent                " 开启新行时使用智能自动缩进
set backspace=indent,eol,start " 不设定在插入状态无法用退格键和 Delete 键删除回车符
set cmdheight=1                " 设定命令行的行数为 1
set laststatus=2               " 显示状态栏 (默认值为 1, 无法显示状态栏)
                               " 设置在状态行显示的信息
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ Ln\ %l,\ Col\ %c/%L%)
set foldenable                 " 开始折叠
set foldmethod=syntax          " 设置语法折叠
set foldcolumn=0               " 设置折叠区域的宽度
setlocal foldlevel=1           " 设置折叠层数为 1
                               " 用空格键来开关折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>  
set scrolloff=4
set tags=./.tags;,.tags        " 当前目录查找tags文件，否则向上递归查找父目录

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <leader>ev :vsplit ~/.vimrc<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

call plug#begin('~/.vim/plugged')
" Add plugins here
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
	let g:Lf_PreviewResult = {'File': 0, 'Function': 0, 'BufTag': 0 }
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
Plug 'ErichDonGubler/vim-sublime-monokai'
	let g:sublimemonokai_term_italic = 1
	autocmd vimenter * ++nested colorscheme sublimemonokai
	let java_comment_strings=1
	let java_highlight_functions=1
	let java_highlight_java_lang_ids=1
Plug 'ghifarit53/tokyonight-vim'
    " let g:tokyonight_style = 'storm' " available: night, storm
    " let g:tokyonight_enable_italic = 1
    " let g:tokyonight_transparent_background=1
    " autocmd vimenter * ++nested colorscheme tokyonight
Plug 'lervag/vimtex'
	let g:tex_flavor='latex'
	"使vimtex默认xelatex为编译器
	let g:vimtex_compiler_latexmk_engines={'_':'-xelatex'}
	let g:vimtex_compiler_latexrun_engines={'_':'xelatex'}
	let g:vimtex_view_method='zathura'
	" let g:vimtex_view_general_viewer='evince'
	let g:vimtex_quickfix_mode=0
    let g:vimtex_compile_automatic = 0
	set conceallevel=1
	let g:tex_conceal='abdmg'
	inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
	nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>
Plug 'sirver/ultisnips'
	let g:UltiSnipsExpandTrigger = '<tab>'
	let g:UltiSnipsJumpForwardTrigger = '<tab>'
	let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
	" Inspired by https://www.skywind.me/blog/archives/2084
	" 定义插件，默认用法，和 Vundle 的语法差不多
Plug 'junegunn/vim-easy-align'
	xmap ga <Plug>(EasyAlign)
	nmap ga <Plug>(EasyAlign)
    " SEE: https://github.com/junegunn/vim-easy-align/blob/master/EXAMPLES.md
    if !exists('g:easy_align_delimiters')
        let g:easy_align_delimiters = {}
    endif
    let g:easy_align_delimiters['#'] = { 'pattern': '#', 'ignore_groups': ['String'] }
" 延迟按需加载，使用到命令的时候再加载或者打开对应文件类型才加载
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" 自动异步生成 tags
Plug 'ludovicchabant/vim-gutentags'
	" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
	let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
	" 所生成的数据文件的名称
	let g:gutentags_ctags_tagfile = '.tags'
	" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
	let s:vim_tags = expand('~/.cache/tags')
	let g:gutentags_cache_dir = s:vim_tags
	" 配置 ctags 的参数
	let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
	let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
	let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'Shougo/echodoc.vim'
  " set noshowmode
  " let g:echodoc_enable_at_startup = 1
	" Or, you could use vim's popup window feature.
	let g:echodoc#enable_at_startup = 1
	let g:echodoc#type = 'popup'
	" To use a custom highlight for the popup window,
	" change Pmenu to your highlight group
	highlight link EchoDocPopup Pmenu
  if has('nvim') || has('patch-8.0.902')
  	Plug 'mhinz/vim-signify'
  else
  	Plug 'mhinz/vim-signify', { 'tag': 'legacy' }
  endif
  " default updatetime 4000ms is not good for async update
  set updatetime=100
Plug 'vim-airline/vim-airline'
	let g:airline_section_z = "%p%% : \ue0a1:%l/%L: Col:%c"
Plug 'vim-airline/vim-airline-themes'
    let g:airline_theme='tokyonight'
Plug 'kaarmu/typst.vim'
	let g:typst_pdf_viewer = "zathura"
	nnoremap <leader>tt :TypstWatch<cr>
Plug 'lervag/vim-foam'
call plug#end()

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove 
"the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" setlocal spell
" set spelllang=en_us
""spell check and correction
" inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

"##### auto fcitx  ###########
let g:input_toggle = 1
function! Fcitx2en()
   let s:input_status = system("fcitx-remote")
   if s:input_status == 2
      let g:input_toggle = 1
      let l:a = system("fcitx-remote -c")
   endif
endfunction

function! Fcitx2zh()
   let s:input_status = system("fcitx-remote")
   if s:input_status != 2 && g:input_toggle == 1
      let l:a = system("fcitx-remote -o")
      let g:input_toggle = 0
   endif
endfunction

set ttimeoutlen=150
"Exit insert mode
autocmd InsertLeave * call Fcitx2en()
"Enter insert mode
autocmd InsertEnter * call Fcitx2zh()
"##### auto fcitx end ######

"Neovim share system clipboard
set clipboard=unnamedplus
"All buffers to tab pages
map ,bt :bufdo tab split<CR>

set numberwidth=5
command! -nargs=* T split | terminal <args>
command! -nargs=* VT vsplit | terminal <args>
set termguicolors

"Insert time stamp
nmap <leader>d i<C-R>=strftime("%Y-%m-%d %a")<CR><Esc>
imap <F3> <C-R>=strftime("%Y-%m-%d")<CR>

"Stack jump by Ctrl+o 2024-12-26 Thu
set jumpoptions+=stack

" Auto closing brackets in vanilla vim
" https://stackoverflow.com/a/34992101/18736354
" inoremap " ""<left>
" inoremap ' ''<left>
" inoremap ( ()<left>
" inoremap [ []<left>
" inoremap { {}<left>
" inoremap {<CR> {<CR>}<ESC>O
" inoremap {;<CR> {<CR>};<ESC>O

" nnoremap E :echo eval(expand('<cword>'))<CR>
nnoremap E :execute 'echo $' . expand('<cword>')<CR>

