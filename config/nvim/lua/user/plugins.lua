local utils = require('user.utils');

return utils.packer_setup(function(use)
  use { 'wbthomason/packer.nvim' }

  use { 'sheerun/vim-polyglot' }

  use {
    'neoclide/coc.nvim',
    branch = 'release',
    config = function()
      vim.g.coc_global_extensions = {
        'coc-emoji', 'coc-eslint', 'coc-prettier', 'coc-tsserver', 'coc-css',
        'coc-json', 'coc-pyls', 'coc-yaml', 'coc-sumneko-lua', 'coc-solargraph'
      }
      -- XXX use vim.fs.normalize when upgraded to nvim 0.8
      vim.g.coc_node_path = vim.fn.expand(
        '~/.nvm/versions/node/v18.8.0/bin/node')
    end
  }

  local devicons = {
    "kyazdani42/nvim-web-devicons",
    config = function()
      require 'nvim-web-devicons'.setup({
        default = true,
      })
    end
  }

  use { 'tpope/vim-fugitive' } -- for :Gblame

  use {
    'nvim-lualine/lualine.nvim',
    requires = { devicons },
    config = function()
      require('lualine').setup {}
    end
  }

  use {
    'ctrlpvim/ctrlp.vim',
    config = function()
      vim.g.ctrlp_max_height = 30
      vim.g.ctrlp_user_command = {
        '.git/',
        'git --git-dir=%s/.git ls-files -oc --exclude-standard'
      }
    end
  }

  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      devicons
    },
    config = function()
      vim.g.neo_tree_remove_legacy_commands = 1
      require("neo-tree").setup {}
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
    config = function()
      require 'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all"
        ensure_installed = { "c", "lua", "typescript", "ruby", "scss", "css" },
      }
    end
  }

  use {
    'folke/which-key.nvim',
    config = function()
      require("which-key").setup()
    end
  }

  use {
    'https://gitlab.com/yorickpeterse/nvim-window.git',
    config = function()
      require('nvim-window').setup({
        chars = { 'd', 'f', 'v', 'e', 'r', 'g' },
      })
    end
  }

  use {
    'beauwilliams/focus.nvim',
    config = function()
      require('focus').setup({})
    end
  }

  use { 'navarasu/onedark.nvim' }
  utils.prequire('onedark', function(onedark) onedark.load() end)
end)
