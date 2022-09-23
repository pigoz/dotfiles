local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

-- search, completion, code analysis and general IDE stuff
Plug('sheerun/vim-polyglot')
Plug('neoclide/coc.nvim', { branch = 'release'})

vim.g.coc_global_extensions = {
  'coc-emoji', 'coc-eslint', 'coc-prettier',  'coc-tsserver', 'coc-css',
  'coc-json', 'coc-pyls', 'coc-yaml'
}

vim.g.coc_node_path = "/Users/pigoz/.nvm/versions/node/v18.8.0/bin/node"

Plug('tpope/vim-fugitive') -- for :Gblame
Plug('nvim-lualine/lualine.nvim')
Plug('ctrlpvim/ctrlp.vim')

vim.g.ctrlp_max_height = 30
vim.g.ctrlp_user_command = {'.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard'}

Plug('kyazdani42/nvim-web-devicons')
Plug('kyazdani42/nvim-tree.lua')
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})

Plug('navarasu/onedark.nvim') -- colorscheme

vim.call('plug#end')

require'nvim-web-devicons'.setup {
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {},
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
  actions = {
    open_file = {
      resize_window = true
    }
  }
})

require("lualine").setup()

require('onedark').load()

vim.cmd([[
inoremap <silent><expr> <c-space> coc#refresh()

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <silent> <D-k> <Plug>(coc-fix-current)
nmap <silent> <D-l> :call CocAction('doHover')<CR>

nmap <silent> <leader>lp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>ln <Plug>(coc-diagnostic-next)

nmap <silent> <leader>ld <Plug>(coc-definition)
nmap <silent> <leader>lt <Plug>(coc-type-definition)
nmap <silent> <leader>li <Plug>(coc-implementation)
nmap <silent> <leader>lf <Plug>(coc-references)

nmap <leader>lr <Plug>(coc-rename)
map <D-b> :CtrlPBuffer<CR>
imap <D-b> :CtrlPBuffer<CR>
map <D-t> :CtrlP<CR>
imap <D-t> :CtrlP<CR>
map <D-d> :NvimTreeToggle<CR>
imap <D-d> <Esc>:NvimTreeToggle<CR>
]])
