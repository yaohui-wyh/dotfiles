set encoding=utf-8
set fileencoding=chinese
set fileencodings=ucs-bom,utf-8,chinese
set ambiwidth=double

set fileformat=unix
set ff=unix

set mouse=a
set number

set backspace=indent,eol,start

set shiftwidth=4
set tabstop=4
set expandtab
set softtabstop=4
set autoindent

set showcmd
set ignorecase " Do case insensitive matching

filetype plugin on

" Copy to CLIPBOARD, and use 'y' to copy to the PRIMARY
map<leader>y "+y
map<leader>p "+p

" Vundle settings
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle "gmarik/vundle"
Bundle "scrooloose/nerdtree"
Bundle "scrooloose/nerdcommenter"
Bundle "vim-scripts/taglist.vim"
Bundle "vim-scripts/cscope_macros.vim"
Bundle "joestelmach/lint.vim"
filetype plugin indent on

" ctags
map <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" Taglist
map <F4> :TlistToggle<CR>
imap <F4> <ESC>:TlistToggle<CR>

" NerdTree
let NERDTreeIgnore=['cscope.in.out', 'cscope.out', 'cscope.files', 'cscope.po.out', 'tags', '\.swp$']
map <F3> :NERDTreeToggle<CR>
imap <F3> <ESC>:NERDTreeToggle<CR>

" NerdCommentor
map <F7> <Leader>cc
imap <F7> <ESC><Leader>cc
map <F8> <Leader>ci
imap <F8> <ESC><Leader>ci

" Format JSON data
nmap jf :%!python -m json.tool<CR>

" Remove trailing whitespace and expand tab
function! Clean()
    exec 'retab'
    exec '%s/\s\+$//e'
endfunction
nmap cls :call Clean()<CR>

" Tab switching
nmap <C-Right> :tabn<CR>
nmap <C-Left> :tabp<CR>
nmap <C-Down> :tabc<CR>
nmap <C-Up> :tabe<CR>
