" Vundle settings
filetype off
call plug#begin('~/.vim/plugged')
" NERD tree will be loaded on the first invocation of NERDTreeToggle command
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/cscope_macros.vim'
Plug 'Shougo/neocomplcache'
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'vim-scripts/matrix.vim--Yang', { 'on': 'Matrix' }
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim'
Plug 'mattn/emmet-vim'
Plug 'kien/ctrlp.vim'
Plug 'octref/RootIgnore'
Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }
Plug 'Chiel92/vim-autoformat', { 'on': 'AutoFormat' }
Plug 'altercation/vim-colors-solarized', { 'on': 'colorscheme solarized' }
Plug 'udalov/kotlin-vim', { 'for': 'kotlin' }
Plug 'kchmck/vim-coffee-script'
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'peitalin/vim-jsx-typescript', { 'for': 'typescript' }
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'ekalinin/dockerfile.vim', { 'for': 'dockerfile' }
Plug 'mxw/vim-jsx'
Plug 'fatih/vim-go'
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-startify'
call plug#end()
filetype plugin indent on


"----------------------------------------------
" GVIM
if has("gui_running")
    winpos 155 155
    set lines=55 columns=125
    colorscheme desert

    "windows GVIM paste shortcut: Ctrl+V (Ctrl + Shfit + v)
    nmap <C-V> "+P
endif

" MacVIM
if system("uname -s") == "Darwin\n"
    set guifont=Monaco:h13
endif

syntax on
set nocompatible
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,chinese
set fileformats=unix,dos
set ambiwidth=double
set number
set autoread    "Read file when changed outside

set mouse=a
set mousehide " Hide the mouse cursor while typing
set backspace=indent,eol,start

set term=xterm-256color
set t_ut=       " Fixing Vim's Background Color
set background=dark
let g:solarized_termcolors=256
" colorscheme solarized
colorscheme desert

set showcmd
set cursorline
hi CursorLine term=bold cterm=bold guibg=Grey40

set wildmode=longest,list,full " Tab completion for filenames
set wildmenu

set scrolloff=4 " Keep 4 lines off the edges of the screen when scrolling

"----------------------------------------------
" Search
set hlsearch    " Highlight search term
nnoremap <CR> :nohlsearch<CR><CR> " click Enter to cancel highlight
set ignorecase  " Do case insensitive matching
set smartcase   " No ignorecase when pattern has uppercase
set incsearch   " Highlight match while typing search pattern

" Yank from the cursor to the end of the line
nnoremap Y y$

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

"----------------------------------------------
" Status line
if has('statusline')
    " Broken down into easily includeable segments
    set laststatus=2
    set statusline=%<%f\ " Filename
    set statusline+=%w%h%m%r " Options
    set statusline+=\ [%{&ff}/%Y] " Filetype
    set statusline+=\ [%{getcwd()}] " Current dir
    set statusline+=\ [%{fugitive#statusline()}] " git indicator
    set statusline+=%=%-14.(%l,%c%V%)\ %p%% " Right aligned file nav info
endif

" Tab stuff
set shiftwidth=4 tabstop=4 softtabstop=4 expandtab
set autoindent

filetype plugin on

"----------------------------------------------
" History
set history=1000
set undolevels=1000
set undofile
set undodir=~/.vim/undo,~/tmp,/tmp

" Gundo
if has('python3')
    let g:gundo_prefer_python3 = 1
endif

" Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" Copy to CLIPBOARD, install vim-gui-common first
vmap <Leader>y "+y
set clipboard=unnamed

" Search and replace in visual mode (C-r), use register h
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" Search for current string (C-k), use register q
vnoremap <C-k> "qy:vimgrep /<C-r>q/gj **<Left><left>

" Using git grep to do cross-branch searching, use register j
vmap <C-h> "jy:!for rev in $(git log --pretty="\%h"); do git grep <C-r>j $rev; done<CR>

" Git command
map <Leader>gg :!git log --graph --date=short --pretty=format:"\%x1b[31m\%h\%x09\%x1b[32m\%d\%x1b[0m\%x20\%ad\%x1b[33m\%x20\%an\%x1b[0m\%x20\%s"<CR>
map <Leader>gl :!git log --stat --abbrev-commit --pretty=short --graph<CR>

" Change the working directory to current folder
" Check if path under 'http://' or 'fugitive://', Avoid crash for fugitive
autocm BufEnter * if expand('%:p') !~ '://' | lcd %:p:h | endif

" Apply macro for highlighted lines
vmap <C-p> :norm! @a


"----------------------------------------------
" plugin configuration and key mapping.

" Gundo Plugin
noremap <Leader>hh :GundoToggle<CR>

" CtrlP (File finder)
" Usage:
" <F5>: purge the cache
" <c-f>: switch mode
" <c-t>: open in a new tab
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = '\v[\/](node_modules|dist)|(\.(git|hg|svn|idea))$'

" Zen-coding
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

autocmd BufNewFile,BufRead *.ejs set filetype=html

" Vim-javascript indentation
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"


" Markdown
let g:vim_markdown_folding_disabled = 1


" ctags
set tags=./tags,tags;/
if has("unix")
    " on OSX
    " $ brew install ctags && alias ctags="`brew --prefix`/bin/ctags"
    map <F12> :!ctags<CR>
endif


" Tagbar
map <F4> :TagbarToggle<CR>
imap <F4> <ESC>:TagbarToggle<CR>

let g:tagbar_width = 30     " width of Tagbar window
let g:tagbar_autofocus = 1  " move to Tagbar window when opened


" NerdTree
let NERDTreeIgnore=['cscope.in.out','cscope.out','cscope.files','cscope.po.out','tags','\.swp$','\.pyc','\~$','\.git','\.svn','\.idea']
map <F3> :NERDTreeToggle<CR>
imap <F3> <ESC> :NERDTreeToggle<CR>

" open a NERDTree automatically when vim starts up if no files were specified or opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif


" NerdCommentor
let NERDSpaceDelims = 1  " Generate an extra space
map <F7> <Leader>cc
imap <F7> <ESC><Leader>cc
map <F8> <Leader>ci
imap <F8> <ESC><Leader>ci


" neocomplcache
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" Enable omni completion.
autocmd FileType javascript setlocal omnifunc=tern#Complete

" Close preview windows automatically
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif


" Tab switching
if system("uname -s") == "Darwin\n"
    nmap <Leader><Right> :tabn<CR>
    imap <Leader><Right> <ESC>:tabn<CR>
    nmap <Leader><Left> :tabp<CR>
    imap <Leader><Left> <ESC>:tabp<CR>
    nmap <Leader><Down> :tabc<CR>
    imap <Leader><Down> <ESC>:tabc<CR>
    nmap <Leader><Up> :tabe<CR>
    imap <Leader><Up> <ESC>:tabe<CR>
else
    nmap <C-Right> :tabn<CR>
    imap <C-Right> <ESC>:tabn<CR>
    nmap <C-Left> :tabp<CR>
    imap <C-Left> <ESC>:tabp<CR>
    nmap <C-Down> :tabc<CR>
    imap <C-Down> <ESC>:tabc<CR>
    nmap <C-Up> :tabe<CR>
    imap <C-Up> <ESC>:tabe<CR>
endif


"----------------------------------------------
" Remove trailing whitespace and expand tab and ^M
function! Clean()
    exec 'retab'
    exec '%s/\s\+$//e'

    " use silent! to omit error message, type in ^M by Ctrl+v and Ctrl+m
    exec 'silent! %s/$//g'
endfunction
nmap cls :call Clean()<CR>
" au FileType c,java,javascript,python,xml,html,yml,mkd autocmd VimEnter * call Clean()

" Delect blank lines:
" exec 'g/^$/d'


"----------------------------------------------
" Add color column
function! AddColorColumn()
    set colorcolumn=120
    highlight ColorColumn ctermbg=green guibg=orange
endfunction
nmap clm :call AddColorColumn()<CR>


"----------------------------------------------
" Simple Template
function! SetTmpl()
    if (&filetype == 'sh')
        normal ggi#!/bin/bash
    elseif (&filetype == 'python')
        normal ggi#!/usr/bin/env python
        put = '# -*- coding: utf-8 -*-'
    endif
    put = '# ==========================================================================='
    put = '# File: ' . expand('%:t')
    put = '# Description: '
    put = '#'
    put = '# Ver 1.0, ' . strftime('%Y-%m-%d ') . substitute(system('whoami'), '\n', '', '') . ', Create file.'
    put = '# ==========================================================================='
endfunction
nmap tpl :call SetTmpl()<CR>


"----------------------------------------------
" Close quick fix window when leaving a file
aug QFClose
    au!
    au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

" win32
if has("win32")
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    language message zh_CN.utf-8
endif

"----------------------------------------------
" Show dos EOL
nmap <Leader>dos :e ++ff=unix %<CR>

"----------------------------------------------
" Vim sudo
cmap w!! w !sudo tee %
