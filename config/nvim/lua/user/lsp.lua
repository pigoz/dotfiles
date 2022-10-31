local M = {}

function M.config()
  -- advertise lsp completion capabilities to the language server
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

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
  require('mason-lspconfig').setup_handlers({
    function(server)
      require("lspconfig")[server].setup({
        capabilities = capabilities,
        on_attach = function()
          require('user.keys').setup_lsp_keybindings()
        end
      })
    end,
    ['sumneko_lua'] = function()
      require('lspconfig').sumneko_lua.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim', 'mp', 'jit' },
            },
          },
        },
      })
    end
  })

  require('trouble').setup()

  -- auto format on save
  vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]]

  -- #########################################################################
  -- completion setup
  -- #########################################################################

  vim.opt.completeopt = { "menu", "menuone", "noselect" }
  vim.opt.shortmess:append "c"

  local cmp = require('cmp')

  cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      -- Accept currently selected item. Set `select` to `false` to only
      -- confirm explicitly selected items.
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = {
      { name = "nvim_lua" },
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'path' },
      { name = 'buffer' },
    },
    experimental = {
      native_menu = false,
      ghost_text = true,
    },
    formatting = {
      format = require('lspkind').cmp_format {
        with_text = true,
        menu = {
          buffer = "[buf]",
          nvim_lsp = "[lsp]",
          nvim_lua = "[vim]",
          path = "[path]",
          luasnip = "[snip]",
          tn = "[t9]",
        },
      },
    }
  })
end

return M
