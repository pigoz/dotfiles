local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

-- search, completion, code analysis and general IDE stuff
Plug('sheerun/vim-polyglot')
Plug('neoclide/coc.nvim', { branch = 'release'})

vim.g.coc_global_extensions = {
  'coc-emoji', 'coc-eslint', 'coc-prettier',  'coc-tsserver', 'coc-css',
  'coc-json', 'coc-pyls', 'coc-yaml', 'coc-sumneko-lua'
}

vim.g.coc_node_path = "/Users/pigoz/.nvm/versions/node/v18.8.0/bin/node"

Plug('tpope/vim-fugitive') -- for :Gblame
Plug('nvim-lualine/lualine.nvim')
Plug('ctrlpvim/ctrlp.vim')

vim.g.ctrlp_max_height = 30
vim.g.ctrlp_user_command = {
  '.git/',
  'git --git-dir=%s/.git ls-files -oc --exclude-standard'
}

Plug('kyazdani42/nvim-web-devicons')
Plug('kyazdani42/nvim-tree.lua')
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
Plug('folke/which-key.nvim')
Plug('https://gitlab.com/yorickpeterse/nvim-window.git')
Plug('beauwilliams/focus.nvim')

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

require("lualine").setup({})
require("which-key").setup()
require('onedark').load()

require('nvim-window').setup({
  chars = { 'd', 'f', 'v', 'e', 'r', 'g' },
})

require('focus').setup({})
