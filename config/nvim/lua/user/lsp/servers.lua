local M = {}

function M.setup()
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
      formatting.prettierd,
      formatting.rubocop,
      diagnostics.rubocop
    },
  })
end

return M
