" Vundle settings
filetype off
call plug#begin('~/.vim/plugged')
" NERD tree will be loaded on the first invocation of NERDTreeToggle command
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'preservim/tagbar'
" universal-ctags, ctags --version
Plug 'vim-scripts/cscope_macros.vim'
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'vim-scripts/matrix.vim--Yang', { 'on': 'Matrix' }
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'octref/RootIgnore'
Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }
Plug 'udalov/kotlin-vim', { 'for': 'kotlin' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'peitalin/vim-jsx-typescript', { 'for': 'typescript' }
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'ekalinin/dockerfile.vim', { 'for': 'dockerfile' }
Plug 'mxw/vim-jsx'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
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
set shortmess-=S

set mouse=a
set mousehide " Hide the mouse cursor while typing
set backspace=indent,eol,start

set term=xterm-256color
set t_ut=       " Fixing Vim's Background Color
set background=dark
let g:solarized_termcolors=256
colorscheme desert

set showcmd
set cursorline
hi CursorLine term=bold cterm=bold guibg=Grey40

set path+=** " Find file recursively `:find xxx` tab to select
set wildmode=longest,list,full " Tab completion for filenames
set wildmenu " Show matched filename tab

set scrolloff=2 " Keep 2 lines off the edges of the screen when scrolling

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

" Git
nmap gbl :Git blame<CR><C-w>w
nmap gcl :Gclog! --graph --pretty=format:'%h - (%ad)%d %s <%an>' --abbrev-commit --date=short -- %<CR>


" Tab stuff
set shiftwidth=4 tabstop=4 softtabstop=4 expandtab
set autoindent

filetype plugin on

"----------------------------------------------
" History
set history=10000
set undolevels=10000
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

" Change the working directory to current folder
" Check if path under 'http://' or 'fugitive://', Avoid crash for fugitive
autocm BufEnter * if expand('%:p') !~ '://' | lcd %:p:h | endif

" Apply macro for highlighted lines
vmap <C-p> :norm! @a


"----------------------------------------------
" plugin configuration and key mapping.

" Gundo Plugin
noremap <Leader>hh :GundoToggle<CR>

" FZF
let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.6, 'relative': v:true, 'yoffset': 1.0 } }
let g:fzf_preview_window = ['right:50%:hidden', 'ctrl-p']
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction
command! ProjectFiles execute 'Files' s:find_git_root()
nmap <C-p> : ProjectFiles<CR>

" Rg search scope set as ProjectRoot
command! -bang -nargs=* PRg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1,
  \ {'dir': system('git -C '.expand('%:p:h').' rev-parse --show-toplevel 2> /dev/null')[:-2]}, <bang>0)
nmap <Leader>pp :PRg<CR>


autocmd BufNewFile,BufRead *.ejs set filetype=html

" Vim-javascript indentation
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"


" Markdown
let g:vim_markdown_folding_disabled = 1


" Tagbar
nmap <F4> :TagbarToggle<CR>

let g:tagbar_width = 30     " width of Tagbar window


" NerdTree
let NERDTreeIgnore=['cscope.in.out','cscope.out','cscope.files','cscope.po.out','tags','\.swp$','\.pyc','\~$','\.git','\.svn','\.idea','node_modules']
nmap <F3> :NERDTreeToggle<CR>

" open a NERDTree automatically when vim starts up if no files were specified or opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif


" NerdCommentor
let NERDSpaceDelims = 1  " Generate an extra space
map <F7> <Leader>cc
imap <F7> <ESC><Leader>cc
map <F8> <Leader>ci
imap <F8> <ESC><Leader>ci

" Close preview windows automatically
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif


" Tab switching
if system("uname -s") == "Darwin\n"
    nmap <Leader><Right> :tabn<CR>
    nmap <Leader><Left> :tabp<CR>
    nmap <Leader><Down> :tabc<CR>
    nmap <Leader><Up> :tabe<CR>
else
    nmap <C-Right> :tabn<CR>
    nmap <C-Left> :tabp<CR>
    nmap <C-Down> :tabc<CR>
    nmap <C-Up> :tabe<CR>
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


" Go syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_functions_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1

" Auto formatting and importing
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"

" Status line types/signatures
let g:go_auto_type_info = 1

" Using gopls
let g:go_def_mode = 'gopls'
let g:go_info_mode = 'gopls'
let g:go_doc_max_height = 20

" Toggle go doc with Ctrl-K
au filetype go map <C-k> :GoDoc<CR>
