vim.cmd([[
nnoremap <CR> :nohlsearch<cr>

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
]])
