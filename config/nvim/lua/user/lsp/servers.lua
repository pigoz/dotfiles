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
    ['yamlls'] = function()
      require('lspconfig').yamlls.setup({
        settings = {
          yaml = {
            schemas = require('user.lsp.schemastore').yaml(),
          }
        }
      })
    end,
    ['jsonls'] = function()
      require('lspconfig').jsonls.setup({
        settings = {
          json = {
            schemas = require('user.lsp.schemastore').json(),
            validate = { enable = true },
          },
        },
      })
    end,
  })

  local null_ls = require("null-ls")
  local formatting = null_ls.builtins.formatting;
  local diagnostics = null_ls.builtins.diagnostics;

  require('user.utils.node').append_nvm_bin_path()

  null_ls.setup({
    sources = {
      formatting.prettierd,
      formatting.rubocop,
      diagnostics.rubocop
    },
  })
end

return M
