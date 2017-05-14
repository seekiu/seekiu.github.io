""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Vundle settings
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/vimfiles/bundle/Vundle.vim/
let path='~/vimfiles/bundle'
call vundle#begin(path)" set the runtime path to include Vundle and initialize

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Add Plugins below
" Colors
Plugin 'tomasr/molokai'
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-scripts/peaksea'
Plugin 'wesgibbs/vim-irblack'
Plugin 'vim-scripts/mayansmoke'
Plugin 'therubymug/vim-pyte'
Plugin 'chriskempson/vim-tomorrow-theme'
Plugin 'vim-scripts/Son-of-Obisidian'

Plugin 'vim-scripts/mru.vim'
Plugin 'ervandew/supertab'
Plugin 'tpope/vim-commentary'
" Plugin 'terryma/vim-multiple-cursors'  " replaced with the builtin `gn` cmd
Plugin 'tpope/vim-surround'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Shougo/neocomplete.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'Raimondi/delimitMate'
Plugin 'skywind3000/asyncrun.vim'
Plugin 'w0rp/ale'
Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'junegunn/vim-easy-align'

""ultisnips
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" General vim settings
let mapleader = ","
let g:mapleader = ","
set noerrorbells  " no annoying sound on errors

set encoding=utf-8
set langmenu=zh_CN.UTF-8
language message zh_CN.UTF-8
source $VIMRUNTIME/delmenu.vim  " 这两行解决菜单栏的乱码
source $VIMRUNTIME/menu.vim
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set termencoding=gbk

" The looks of Vim
" set guifont=Microsoft\ YaHei\ Mono:h13  "设置字体和字号
set guifont=Consolas:h13
set lines=35 columns=86          "设置vim窗口的大小
if has('gui_running')
    " colorscheme Tomorrow-Night
    " colorscheme mayansmoke
    colorscheme pyte
    let g:molokai_original = 0
    let g:rehash256 = 1
    " set background=light
    " set background=dark
    set guioptions+=m
    set guioptions-=T  " no toolbar
else
    colorscheme molokai
endif
syntax enable
syntax on
set cursorline  " highlight current line.
set colorcolumn=80  " mark the 80 column
" set renderoptions=type:directx,renmode:5,taamode:1

set nobackup  " 关于备份的设置
" set backupext=.bak
" set backupdir=C:\Users\Charles\AppData\Roaming\Vim\Backup
set noswapfile
set noundofile

set tabstop=4  " 一个tab显示的长度，默认是8
set softtabstop=4  " 按退格键时退回缩进的长度
set shiftwidth=4  " 每一级缩进的长度
set expandtab  " 用空格来代替tab

set number  " line numbering
set relativenumber
set ignorecase smartcase

set ai "Auto indent
set cindent "dont't turn on smart indent, it interferes w/ python's comment
set wrap "Wrap lines

set incsearch
set hlsearch

set autoread  " auto read when file is changed from outside

set ruler  " always show current position

set cmdheight=1  " height of the command bar

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Press alt+y or u to scroll the view, rather convenient
noremap <A-y> 5<C-e>
noremap <A-u> 5<C-y>

" Faster way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Building source codes
autocmd FileType python nmap <leader>f :w!<cr>:AsyncRun python "%"<cr>:copen<cr>
autocmd FileType python nmap <leader>b :w!<cr>:AsyncRun python "%"<cr>
" autocmd FileType c nmap <leader>b :w!<cr>:!gcc "%" -o ww<cr>:!ww.exe<cr>
" autocmd FileType cpp nmap <leader>b :w!<cr>:!g++ % -o ww -O3 -fopenmp<cr>
"     \:!ww.exe<cr>

" Fast switch tabs
nmap <leader>w gT
nmap <leader>e gt

" Quick view of the registers
nmap <leader>r :reg<cr>

" Code folding, for python
set foldmethod=indent
set foldlevel=99

set cryptmethod=blowfish2  " use the securer encryption method.

" Format the status line, `h:status-line` to see how to setup
set laststatus=2  " alwasy shown the status line
set statusline=%m%r%w  " tags for modified,readonly and preview
set statusline+=\ Line:\ %l/%L
set statusline+=\ \ \
set statusline+=[%.50{getcwd()}]
set statusline+=
set statusline+=%=\ \ %y\   " '%=' alignes right hand side.

set nopaste  " we don't want reformatting when pasting

map <silent> <leader><cr> :noh<cr>  " fast disable highlight

" Move cursor to the next paragraph and put it on top of screen.
" map <Space> }zt

" Removing trailing spaces
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Remember last cursor position
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") |
      \exe "normal! g'\"" | endif
endif

set display+=lastline  " show sections of wrapped long lines in the end

map <leader>q :tabe <cr>  " quickly open new tab for note

nnoremap ,cd :cd %:p:h<CR>  " change CWD to current file

nmap <leader><space> i <esc>la <esc>h  " quickly insert 2 spaces around a char
nmap <leader>o o<esc>k  " quickly add blank line below
nmap <leader>O O<esc>j  " quickly add blank line above

map <f12> :!start /min ctags -R .<cr>  " press f12 to generate tags file

nmap <leader>svr :!start python -m http.server<cr>

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Mode line (settings put in the start of a file)
set modeline
set modelines=5
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Supertab settings
let g:SuperTabDefaultCompletionType = '<C-n>'
let g:SuperTabCrMapping = 0
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""




""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" easy-align settings
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""




""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" ale settings
let g:ale_lint_on_save = 0
let g:ale_lint_on_text_changed = 0
" diable linters to run on opening a file
let g:ale_lint_on_enter = 0
let g:ale_python_pylint_options = '--disable=C0103,C0111,C0326'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Jedi-vim settings
" let g:jedi#smart_auto_mappings = 0  " turnoff the stupid 'from xx import' popup
" let g:jedi#force_py_version = 3
" let g:jedi#popup_on_dot = 0
" let g:jedi#show_call_signatures = "0"
" let g:jedi#popup_select_first=0
" set completeopt=longest,menuone
" let g:jedi#auto_vim_configuration = 0
" let g:jedi#popup_on_dot = 0
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Neocomplete settings
autocmd FileType markdown NeoCompleteLock  " disable it for markdown
autocmd FileType tex NeoCompleteLock  " disable it for tex
let g:neocomplete#enable_at_startup = 1  " automatically start with vim
" nmap <leader>n :NeoCompleteEnable<cr>  " Manually enable neocomplete
let g:neocomplete#max_list = 20  " Maximum number of candidates
let g:neocomplete#max_keyword_width = 40  " Max width of candidate displayed
let g:neocomplete#min_keyword_length = 3  " Min length of indexed keywords
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#use_vimproc = 1
let g:acp_enableAtStartup = 1  " acp = auto-completion-pop
let g:neocomplete#auto_complete_delay = 1  " delay time for auto completion
" Explicitly telling neocomplete to use python3
autocmd FileType python setlocal omnifunc=python3complete#Complete
" " <TAB>: completion.
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" :
"     \ <SID>check_back_space() ? "\<TAB>" :
"     \ neocomplete#start_manual_complete()
" function! s:check_back_space() "{{{
" let col = col('.') - 1
" return !col || getline('.')[col - 1]  =~ '\s'
" endfunction"}}}




" " let g:acp_enableAtStartup = 1  " AutoComplPop
" let g:neocomplete#disable_auto_complete = 1
" " Enable omni completion.
" autocmd FileType python setlocal omnifunc=jedi#completions
" " let g:neocomplete#enable_auto_select = 0
" if !exists('g:neocomplete#force_omni_input_patterns')
"         let g:neocomplete#force_omni_input_patterns = {}
" endif
" " let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Syntastic settings
" let g:syntastic_mode_map = { 'mode': 'passive' }
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" ultisnips setup
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim-commentary setting
autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fast toggle comment, requires vim-commentary
" nmap <leader>z gcc
" vmap <leader>z gc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" CtrlP related settings
" let g:ctrlp_custom_ignore = {
"     \ 'dir':  '\v[\/]\.(git|hg|svn)$',
"     \ 'file': '\v\.(pdf|doc|docx|docm|7z|zip|rar|png|jpg|jpeg|exe|so|dll)$',
"     \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
"     \ }
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indent guide, work with the plugin, key is <leader>ig
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
let g:indent_guides_auto_colors=1
" hi IndentGuidesOdd  ctermbg=white
" hi IndentGuidesEven ctermbg=lightgrey
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vimtex settings
" let g:vimtex_enabled=0  " I'm disabling it until I figure out how to use it.
" let g:tex_flavor='latex'
" let g:vimtex_view_general_viewer='SumatraPDF'
" let g:vimtex_view_general_options
"     \ = '-reuse-instance -forward-search @tex @line @pdf'
" let g:vimtex_view_general_options_latexmk='-reuse-instance'
" let g:vimtex_latexmk_options = '-xelatex -bibtex-cond'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim-multiple-cursors settings
let g:multi_cursor_start_key='<C-n>'
let g:multi_cursor_start_word_key='g<C-n>'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Chinese word count
"source:https://www.zhihu.com/question/54118781/answer/137982087
function! ChineseCount() range
	let save = @z
	silent exec 'normal! gv"zy'
	let text = @z
	let @z = save
	silent exec 'normal! gv'
	let cc = 0
	for char in split(text, '\zs')
		if char2nr(char) >= 0x2000
			let cc += 1
		endif
	endfor
	echo "Count of Chinese charasters is:"
	echo cc
endfunc

vnoremap <F7> :call ChineseCount()<cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"" the original _vimrc file content.
set nocompatible
" source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin


" set formatoptions=qrn1  " check h: fo-tabel for explanation
set formatoptions=cqn  " check h: fo-tabel for explanation
set formatoptions+=mM  " 对中文也断行
set textwidth=79

" Other file type dependent settings
" autocmd FileType tex colorscheme mayansmoke
" autocmd FileType markdown colorscheme mayansmoke
autocmd FileType markdown nmap <leader>f gqip
autocmd FileType markdown set fo+=t
autocmd FileType markdown set linespace=8
autocmd FileType markdown set lines=30
autocmd FileType tex set linespace=8
autocmd FileType tex set lines=30
autocmd FileType tex set fo+=t  " 超过textwidth时自动折行
autocmd FileType tex nmap <leader>f gqip
autocmd FileType tex set guifont=Microsoft\ YaHei\ Mono:h14
autocmd FileType tex set indentkeys=  " 关闭烦人的输入括号就缩进的「功能」
autocmd FileType tex set nocursorline  " 关闭高亮当前行，提高响应速度
autocmd FileType tex nmap <F5> :w<cr>:!start build.bat<cr>
autocmd FileType tex nmap <F6> :w<cr>:!start compile-print.bat<cr>

"" Edit log
" 2015-5-29 move it to dropbox, and make symbolic link to local PC.
" 2016-4-25 reorganize and greatly improve the structure of this file.
