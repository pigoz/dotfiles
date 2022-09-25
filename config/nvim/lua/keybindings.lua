local wk = require("which-key")

wk.register({
  ["<leader>d"] = { ":NvimTreeToggle<cr>", "toggle tree" },
  ["<leader>."] = {
    name = "+config",
    ['e'] = { ':e $MYVIMRC<cr>', 'edit' },
    ['r'] = { function() ReloadConfig() end, 'reload' },
  },
  ["<leader>w"] = {
    name = '+nav',
    h = { '<c-w>h', 'Left Window' },
    j = { '<c-w>j', 'Bottom Window' },
    k = { '<c-w>k', 'Top Window' },
    l = { '<c-w>l', 'Right Window' },
    f = { 'za', 'fold toggle' },
    d = { 'zR', 'fold clear all' },
  },
  ["<leader>j"] = {
    name = '+lsp',
    ['.'] = { ':CocConfig'                          , 'config'},
    [';'] = { '<Plug>(coc-refactor)'                , 'refactor'},
    ['a'] = { '<Plug>(coc-codeaction)'              , 'line action'},
    ['A'] = { '<Plug>(coc-codeaction-selected)'     , 'selected action'},
    ['b'] = { ':CocNext'                            , 'next action'},
    ['B'] = { ':CocPrev'                            , 'prev action'},
    ['c'] = { ':CocList commands'                   , 'commands'},
    ['d'] = { '<Plug>(coc-definition)'              , 'definition'},
    ['D'] = { '<Plug>(coc-declaration)'             , 'declaration'},
    ['e'] = { ':CocList extensions'                 , 'extensions'},
    ['f'] = { '<Plug>(coc-format-selected)'         , 'format selected'},
    ['F'] = { '<Plug>(coc-format)'                  , 'format'},
    ['h'] = { '<Plug>(coc-float-hide)'              , 'hide'},
    ['i'] = { '<Plug>(coc-implementation)'          , 'implementation'},
    ['I'] = { ':CocList diagnostics'                , 'diagnostics'},
    ['j'] = { '<Plug>(coc-float-jump)'              , 'float jump'},
    ['l'] = { '<Plug>(coc-codelens-action)'         , 'code lens'},
    ['n'] = { '<Plug>(coc-diagnostic-next)'         , 'next diagnostic'},
    ['N'] = { '<Plug>(coc-diagnostic-next-error)'   , 'next error'},
    ['o'] = { '<Plug>(coc-openlink)'                , 'open link'},
    ['O'] = { ':CocList outline'                    , 'outline'},
    ['p'] = { '<Plug>(coc-diagnostic-prev)'         , 'prev diagnostic'},
    ['P'] = { '<Plug>(coc-diagnostic-prev-error)'   , 'prev error'},
    ['q'] = { '<Plug>(coc-fix-current)'             , 'quickfix'},
    ['r'] = { '<Plug>(coc-rename)'                  , 'rename'},
    ['R'] = { '<Plug>(coc-references)'              , 'references'},
    ['s'] = { ':CocList -I symbols'                 , 'references'},
    ['S'] = { ':CocList snippets'                   , 'snippets'},
    ['t'] = { '<Plug>(coc-type-definition)'         , 'type definition'},
    ['u'] = { ':CocListResume'                      , 'resume list'},
    ['U'] = { ':CocUpdate'                          , 'update CoC'},
    ['v'] = { ':Vista!!'                            , 'tag viewer'},
    ['z'] = { ':CocDisable'                         , 'disable CoC'},
    ['Z'] = { ':CocEnable'                          , 'enable CoC'},
  },
})

vim.cmd([[
inoremap <silent><expr> <c-space> coc#refresh()

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

map <D-b> :CtrlPBuffer<CR>
imap <D-b> :CtrlPBuffer<CR>
map <D-t> :CtrlP<CR>
imap <D-t> :CtrlP<CR>
map <D-d> :NvimTreeToggle<CR>
imap <D-d> <Esc>:NvimTreeToggle<CR>

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

nnoremap ; :CtrlP<CR>
]])

function ReloadConfig()
  for name,_ in pairs(package.loaded) do
    package.loaded[name] = nil
  end

  dofile(vim.env.MYVIMRC)
  vim.notify("nvim config reloaded!", vim.log.levels.INFO)
end
