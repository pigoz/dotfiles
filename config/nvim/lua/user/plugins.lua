return require("user.lazy").setup({
  "sheerun/vim-polyglot",
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      {
        "hrsh7th/nvim-cmp",
        opts = {
          sources = {
            {
              name = "ruby_css",
              option = {
                globs = { "mdb.css" },
              },
            }
          }
        }
      },
      "onsails/lspkind.nvim",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "folke/trouble.nvim",
      "b0o/SchemaStore.nvim", -- schema store for yaml and json files
      "nvim-tree/nvim-web-devicons",
      {
        "pigoz/nvim-ruby-css",
        dir = "~/dev/nvim-ruby-css",
        dependencies = {
          "nvim-treesitter/nvim-treesitter",
          "nvim-lua/plenary.nvim"
        },
        config = function()
          require("ruby-css"):setup()
        end
      },
    },
    config = require("user.lsp").setup,
  },

  "tpope/vim-fugitive", -- for :Gblame

  {
    "voldikss/vim-floaterm",
    config = function()
      vim.g.floaterm_height = 0.999
      vim.g.floaterm_width = 0.999
      vim.g.floaterm_title = ''
      vim.g.floaterm_opener = 'tabe'
    end
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({})
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              -- instantly quit telescope instead of switching to normal mode
              ["<esc>"] = require("telescope.actions").close,
            },
          },
        },
      })
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      vim.g.neo_tree_remove_legacy_commands = 1
      require("neo-tree").setup({})
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
    config = function()
      require("nvim-treesitter.configs").setup({
        -- A list of parser names, or "all"
        ensure_installed = {
          "c",
          "lua",
          "typescript",
          "ruby",
          "scss",
          "css",
          "html",
          "embedded_template",
        },

        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects"
    }
  },

  {
    "folke/which-key.nvim",
    config = function()
      local wk = require("which-key")
      local keys = require("user.keys")
      wk.setup({})
      keys.setup_which_key_bindings(wk)
      keys.setup_global_key_bindings()
    end,
  },


  {
    "goolord/alpha-nvim",
    -- alpha is a fast and fully programmable greeter for neovim
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("alpha").setup(require("alpha.themes.startify").config)
    end,
  },

  {
    "beauwilliams/focus.nvim",
    -- auto splits using golden ratio
    config = function()
      require("focus").setup({})
    end,
  },

  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").add_default_mappings()
      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")
    end,
  },

  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  {
    "navarasu/onedark.nvim",
    config = function()
      require("onedark").setup()
      require("onedark").load()
    end,
  },
})
