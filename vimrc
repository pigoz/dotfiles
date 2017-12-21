" Basic stuff
set nocompatible         " no vi compatibility

if filereadable(glob("~/.vimrc.plugins")) 
  source ~/.vimrc.plugins
endif

set number           " line numbers
set fileformat=unix  " LF line endings

" Turn on auto indentation
filetype indent on
filetype plugin on

" Use 2 spaces softtabs for everything except for languages where the
" convention is 4spaces softtabs
autocmd FileType * set ts=2 sw=2 sts=2 expandtab
autocmd FileType c,m,h,cpp,hpp,glsl,objc,python,php,swift,rust set ts=4 sw=4 sts=4 expandtab
autocmd FileType make set noexpandtab " make needs them tabs

" Serious indentation for XML
autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
autocmd FileType json setlocal equalprg=jsonlint\ -\ 2>/dev/null

" Colorscheme
syntax on
set termguicolors
colorscheme space-vim-dark
hi Comment cterm=italic
hi SpellCap guisp=#af87d7

set listchars=tab:▸·,eol:¬,trail:·
set cursorline   " Highlight current line
set list         " Activate listchars configuration
set ruler        " Show row / column
set showcmd      " Shows selection
set incsearch    " Use incremental search
set hlsearch     " Highlight search results

" Natural splits
set splitbelow
set splitright

let s:fontsize = 20
let &guifont = escape("Menlo" . ":h" . s:fontsize, ' ')

" Hide MacVim GUI elements
set go-=T
set go-=m

set virtualedit=all      " Allow to move cursor anywhere
set clipboard=unnamed    " Uses system clipboard
let mapleader = ' '
nnoremap <SPACE> <Nop>

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
set cmdheight=2          " Command buffer height = 2

set title                " Change the terminal's title
set visualbell           " Don't beep
set noerrorbells         " Don't beep

set nobackup             " I use git anyway
set noswapfile           " See previous line

set pastetoggle=<F2>     " Allows to enter 'paste mode'

set modeline
set modelines=2

" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=
" keep more context when scrolling off the end of a buffer
set scrolloff=3

" Ignore these files when using CtrlP
" * Rails specific
set wildignore+=*/tmp/*,*/.sass_cache/*,*/vendor/assets/*,*/public/assets/*
" * Python specific
set wildignore+=*.pyc*
" * C specific
set wildignore+=*/build/*,*.d,*.o
" * SCM specific
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
" * JavaScript specific
set wildignore+=*/dist/*,*/bower_components/*,*/node_modules/*,*/jspm_packages/*

" Really useful to save a file with sudo
cmap w!! w !sudo tee % >/dev/null

" Clears the search buffer when hitting return
nnoremap <CR> :nohlsearch<cr>

" Better indentation
vnoremap < <gv
vnoremap > >gv

" disable Ex mode
nnoremap Q <Nop>
imap <Home> <Esc>
vnoremap <Home> <Esc>

" easier window navigation
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

nnoremap <c-down> <c-w>j
nnoremap <c-up> <c-w>k
nnoremap <c-left> <c-w>h
nnoremap <c-right> <c-w>l

" OSX-like window navigation
map <D-M-Left> <c-w>h
imap <D-M-Left> <c-w>h
map <D-M-Right> <c-w>l
imap <D-M-Right> <c-w>l
map <D-M-Up> <c-w>k
imap <D-M-Up> <c-w>k
map <D-M-Down> <c-w>j
imap <D-M-Down> <c-w>j

nnoremap <PageUp> <C-u>
nnoremap <PageDown> <C-d>

nnoremap gp :silent %!prettier --stdin<cr>

" fold like no tomorrow (toggle)
nnoremap <Leader>ff za
" fold like no tomorrow (clear all)
nnoremap <Leader>fd zR
nnoremap <Leader>gb :Gblame<cr>
nnoremap <Leader>gh :Gbrowse<cr>
nnoremap <Leader>p gp
nnoremap ; :CtrlP<CR>
nnoremap <Leader>; :CtrlPBuffer<CR>
nnoremap <Leader>v :vsplit<CR>
nnoremap <Leader>h :split<CR>
imap jj <Esc>
imap jk <Esc>
