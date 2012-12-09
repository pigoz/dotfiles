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
Bundle 'kien/ctrlp.vim'
Bundle 'mileszs/ack.vim'
Bundle 'ervandew/supertab'
Bundle 'tpope/vim-fugitive'
Bundle 'vim-scripts/bufkill.vim'
Bundle 'vim-scripts/buftabs'
Bundle 'vim-scripts/taglist.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'Lokaltog/vim-powerline'

" colorschemes
Bundle 'pigoz/herald'
Bundle 'chriskempson/vim-tomorrow-theme'

" languages packages
Bundle 'b4winckler/vim-objc'
Bundle 'derekwyatt/vim-scala'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'vim-ruby/vim-ruby'
Bundle 'pangloss/vim-javascript'
Bundle 'wlangstroth/vim-haskell'
Bundle 'kchmck/vim-coffee-script'
Bundle 'Nemo157/glsl.vim'

" Turn on auto indentation
filetype indent on

" Use 2 spaces softtabs for everything except for languages where the
" convention is 4spaces softtabs
autocmd FileType * set ts=2 sw=2 sts=2 expandtab
autocmd FileType c,m,h,cpp,hpp,glsl,objc,python set ts=4 sw=4 sts=4 expandtab

" Colorscheme
syntax on
set t_Co=256
set background=dark

colorscheme tomorrow-night

set listchars=tab:▸·,eol:¬,trail:·

" The following assume t_Co == 256 for term colors
 "For a color table check http://en.wikipedia.org/wiki/Xterm
highlight NonText ctermfg=236 guifg=#303030
highlight SpecialKey ctermfg=236 guifg=#303030
highlight ColorColumn ctermbg=0
highlight CursorLine term=none gui=none

set cursorline           " Highlight current line
set list                 " Activate listchars configuration
set ruler                " Show row / column
set showcmd              " Shows selection
set incsearch            " Use incremental search
set hlsearch             " Highlight search results

" Setting fonts
set gfn=Inconsolata\ 16
set guifont=Inconsolata:h16

" Hide MacVim GUI elements
set go-=T
set go-=m

set virtualedit=all      " Allow to move cursor anywhere
set clipboard=unnamed    " Uses system clipboard
let mapleader = ','

" Folding options
set foldmethod=syntax
set nofoldenable         " Don't fold by default

" CTags FTW!
let g:ctags_path = "/usr/local/bin/ctags"

" Load tags from more places
set tags+=gems.tags

function GenCTags(target, sources)
  execute ':! ' . g:ctags_path . ' -R -a -f ' . a:target . ' ' . a:sources
endfunction

command Ct     call GenCTags('tags', '.')
command Ctgems call GenCTags('gems.tags', '`bundle show --paths`')

map <Leader>d <C-]>
map à <C-]>

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

" Ignore these  files when using CtrlP
set wildignore+=*/build/*,*/.git/*,*/.hg/*,*/.svn/*,*.d*,*.o*

" Really useful to save a file with sudo
cmap w!! w !sudo tee % >/dev/null

" Clears the search buffer when hitting return
nnoremap <CR> :nohlsearch<cr>

" Better indentation
vnoremap < <gv
vnoremap > >gv

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

"------------------------------------------------------------------------------
" Plugin specific settings
"------------------------------------------------------------------------------

" Ack bindigns
map <D-F> :Ack<space>
imap <D-F> <Esc>:Ack<space>

" CtrlP bindings
map <D-e> :CtrlPBuffer<CR>
imap <D-e> :CtrlPBuffer<CR>
map <D-r> :CtrlPMRU<CR>
imap <D-r> :CtrlPMRU<CR>
map <D-t> :CtrlP<CR>
imap <D-t> :CtrlP<CR>

let g:ctrlp_max_height = 30

" Bind command + W to BD plugin
map <D-w> :BD<CR>
imap <D-w> <Esc>:BD<CR>

" Taglist
map <Leader>l :TlistToggle<CR>
let Tlist_Ctags_Cmd = g:ctags_path
let Tlist_Use_Right_Window = 1
let Tlist_WinWidth = 35
let Tlist_Enable_Fold_Column = 0
let Tlist_Show_One_File = 1

" Nerdtree
" Toggle drawer bindings
map <D-d> :NERDTreeToggle<CR>
imap <D-d> <Esc>:NERDTreeToggle<CR>

let NERDTreeShowHidden=1      " Show dotfiles in NERDTree
let NERDTreeHijackNetrw = 0   " Don't hijack Netrw
let NERDTreeIgnore = ['\.pyc$', '\.d$', '\.o$']

autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Powerline
set laststatus=2
