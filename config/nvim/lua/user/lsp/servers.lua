local M = {}

function M.setup()
  -- advertise lsp completion capabilities to the language server
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  require("mason").setup()

  require('mason-lspconfig').setup({
    ensure_installed = {
      'emmet_language_server',
      'jsonls',
      'yamlls',
      'cssls',
      'lua_ls',
      'ts_ls',
    },
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
    ['lua_ls'] = function()
      require('lspconfig').lua_ls.setup({
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

  local util = require('lspconfig').util;

  require('lspconfig').rubocop.setup({
    cmd = { vim.fn.expand("~/.rbenv/shims/rubocop"), '--lsp' },
    filetypes = { 'ruby' },
    root_dir = util.root_pattern('Gemfile', '.git'),
  })

  require('lspconfig').dprint.setup({
    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "css",
      "scss",
      "json",
      "jsonc",
      "markdown",
      "html",
      "eruby"
    }
  });

  require('lspconfig').ruby_lsp.setup({
    cmd = { vim.fn.expand("~/.rbenv/shims/ruby-lsp") },
    root_dir = util.root_pattern("Gemfile", ".git", "."),
    init_options = {},
    filetypes = { 'ruby', 'eruby' }
  });

  require('lspconfig').solargraph.setup({
    cmd = { vim.fn.expand("~/.rbenv/shims/solargraph"), 'stdio' },
    root_dir = util.root_pattern("Gemfile", ".git", "."),
    settings = {
      solargraph = {
        autoformat = false,
        completion = true,
        diagnostic = false,
        folding = false,
        references = true,
        rename = true,
        symbols = true
      }
    },
  });
end

return M
