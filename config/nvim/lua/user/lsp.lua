local M = {}

function M.format(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      local blacklist = { 'tsserver' }
      return not require('user.utils').table.contains(blacklist, client.name)
    end,
    bufnr = bufnr or vim.api.nvim_get_current_buf(),
  })
end

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
        on_attach = function(client, bufnr)
          require('user.keys').setup_lsp_keybindings(client, bufnr)
        end
      })
    end,
    ['sumneko_lua'] = function()
      require('lspconfig').sumneko_lua.setup({
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
            },
            diagnostics = {
              globals = { 'vim', 'mp', 'jit' },
            },
          },
        },
      })
    end,
  })

  local null_ls = require("null-ls")
  local formatting = null_ls.builtins.formatting;
  local diagnostics = null_ls.builtins.diagnostics;

  -- XXX handle nvm lazy mode + prettier in a less shitty way
  vim.opt.path:append(vim.fs.normalize('~/.nvm/versions/node/v18.8.0/bin'))

  null_ls.setup({
    sources = {
      formatting.prettier,
      formatting.rubocop,
      diagnostics.rubocop
    },
  })

  -- auto format on save
  vim.cmd [[autocmd BufWritePre * lua require('user.lsp').format()]]

  -- setup completion
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

  -- setup cosmetics
  require('trouble').setup()

  local icons = {
    Error = "",
    Warn = "",
    Info = "",
    Hint = "",
  }

  local icons_diagnostic = {
    [vim.diagnostic.severity.ERROR] = icons.Error,
    [vim.diagnostic.severity.WARN] = icons.Warn,
    [vim.diagnostic.severity.INFO] = icons.Info,
    [vim.diagnostic.severity.HINT] = icons.Hint,
  }

  for severity, text in pairs(icons) do
    local name = 'DiagnosticSign' .. severity
    vim.fn.sign_define(name, {
      texthl = name,
      text = text,
      numhl = ""
    })
  end

  local function virtual_text_format(diagnostic)
    local icon = icons_diagnostic[diagnostic.severity]
    return string.format(
      '%s %s: %s [%s]',
      icon,
      diagnostic.code,
      diagnostic.message,
      diagnostic.source
    )
  end

  local conf = {
    virtual_text = {
      prefix = '',
      spacing = 2,
      source = false,
      format = virtual_text_format,
    },
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focus = false,
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(conf)
end

return M
