" Basic stuff
set nocompatible
set number
filetype off             " Reuired by Vundle
set fileformat=unix

" Vundles
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'
Bundle 'pigoz/herald'
Bundle 'kien/ctrlp.vim'
Bundle 'mileszs/ack.vim'

" Colorscheme
syntax on
set t_Co=256
set background=dark
colorscheme herald

" Setting fonts
set gfn=Inconsolata\ 16
set guifont=Inconsolata:h16

" Hide MacVim GUI elements
set go-=T
set go-=m

set virtualedit=all      " Allow to move cursor anywhere
set clipboard=unnamed    " Uses system clipboard
let mapleader = '\'

" Folding options
set foldmethod=syntax
set nofoldenable         " Don't fold by default

" Allow backgrounding buffers without writing them, and remember marks/undo
" for backgrounded buffers
set hidden

" Make searches case-sensitive only if they contain upper-case characters
set ignorecase
set smartcase

set colorcolumn=80
set winwidth=83          " 79(+4 for line numbers)
set cursorline           " Highlight current line
set cmdheight=2          " Command buffer height = 2

set title                " Change the terminal's title
set visualbell           " Don't beep
set noerrorbells         " Don't beep

set nobackup             " I use git anyway
set noswapfile           " See previous line

set pastetoggle=<F2>     " Allows to enter 'paste mode'

set modeline
set modelines=2

" Change the color column to black
highlight ColorColumn ctermbg=7

" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=
" keep more context when scrolling off the end of a buffer
set scrolloff=3

" Ignore these  files when using CtrlP
set wildignore+=*/build/*,*/.git/*,*/.hg/*,*/.svn/*,*.d*

" Really useful to save a file with sudo
cmap w!! w !sudo tee % >/dev/null

" Clears the search buffer when hitting return
nnoremap <CR> :nohlsearch<cr>

" Move through windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

nnoremap <c-down> <c-w>j
nnoremap <c-up> <c-w>k
nnoremap <c-left> <c-w>h
nnoremap <c-right> <c-w>l

" Next/prev buffer bindings
map <D-M-Left> :bprev<CR>
imap <D-M-Left> <Esc>:bprev<CR>
map <D-M-Right> :bnext<CR>
imap <D-M-Right> <Esc>:bnext<CR>

" CtrlP bindings
map <D-e> :CtrlPBuffer<CR>
imap <D-e> :CtrlPBuffer<CR>
map <D-r> :CtrlPMRU<CR>
imap <D-r> :CtrlPMRU<CR>
map <D-t> :CtrlP<CR>
imap <D-t> :CtrlP<CR>

" Bind command + W to BD plugin
map <D-w> :BD<CR>
imap <D-w> <Esc>:BD<CR>

" Toggle drawer bindings
" map <D-d> :NERDTreeToggle<CR>
" imap <D-d> <Esc>:NERDTreeToggle<CR>

" Show dotfiles in NERDTree
" let NERDTreeShowHidden=1

" Language specific customazions
" Handle C like languages correctly
autocmd FileType c,m,h,objc,python set sw=4 sts=4 et
