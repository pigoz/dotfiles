return require('user.packer').setup(function(use)
  use { 'wbthomason/packer.nvim' }

  use { 'sheerun/vim-polyglot' }

  use {
    "neovim/nvim-lspconfig",
    requires = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "ms-jpq/coq_nvim",
        run = ':COQdeps',
        branch = 'coq',
        requires = {
          'ms-jpq/coq.thirdparty',
          branch = '3p'
        }
      }
    },
    config = function()
      vim.g.coq_settings = {
        auto_start = 'shut-up',
        clients = {
          tree_sitter = { enabled = false },
          paths = { enabled = false, resolution = { 'file' } },
          snippets = { enabled = false, warn = {} },
          tags = { enabled = false },
          lsp = { enabled = true, always_on_top = { 'lsp/tsserver' } }
        },
        keymap = {
          recommended = true,
          pre_select = true,
        },
        display = {
          icons = {
            mode = "short"
          }
        }
      }
      local coq = require('coq')
      require("mason").setup()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'jsonls',
          'yamlls',
          'cssls',
          'sumneko_lua',
          'tsserver',
          -- 'ruby_ls'
        },
        -- automatic_installation = true,
      })
      require("mason-lspconfig").setup_handlers({
        function(server)
          require("lspconfig")[server].setup(coq.lsp_ensure_capabilities({
            on_attach = function()
              require('user.keys').setup_lsp_keybindings()
            end
          }))

          if server == 'sumneko_lua' then
            require('lspconfig').sumneko_lua.setup({
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim" },
                  },
                },
              },
            })
          end
        end
      })
      vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]]
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
  use { 'kdheepak/lazygit.nvim' }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { devicons },
    config = function()
      require('lualine').setup {}
    end
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              -- instantly quit telescope instead of switching to normal mode
              ["<esc>"] = require('telescope.actions').close,
            },
          }
        }
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
      local wk = require("which-key")
      local keys = require("user.keys")
      wk.setup {}
      keys.setup_which_key_bindings(wk)
      keys.setup_global_key_bindings()
    end
  }

  use { 'glepnir/dashboard-nvim', config = function()
    local db = require('dashboard')
    local dbconfig = require('user.dashboard')
    db.custom_header = dbconfig.custom_header
    db.custom_center = dbconfig.custom_center
    db.custom_footer = dbconfig.custom_footer
  end }

  use {
    'beauwilliams/focus.nvim',
    config = function()
      require('focus').setup({})
    end
  }

  use {
    'ggandor/leap.nvim',
    config = function()
      require('leap').add_default_mappings()
      vim.keymap.del({ 'x', 'o' }, 'x')
      vim.keymap.del({ 'x', 'o' }, 'X')
    end
  }

  use {
    'navarasu/onedark.nvim',
    config = function()
      require('onedark').load()
    end
  }
end)
