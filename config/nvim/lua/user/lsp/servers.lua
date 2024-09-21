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
      'lua_ls',
      'tsserver',
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

  local null_ls = require("null-ls")
  local formatting = null_ls.builtins.formatting;
  local diagnostics = null_ls.builtins.diagnostics;

  null_ls.setup({
    sources = {
      formatting.prettierd,
      formatting.rubocop,
      formatting.erb_format,
      diagnostics.rubocop,
    },
  })

  require('lspconfig').solargraph.setup({
    cmd = { vim.fn.expand("~/.rbenv/shims/solargraph"), 'stdio' },
    root_dir = require('lspconfig').util.root_pattern("Gemfile", ".git", "."),
    settings = {
      solargraph = {
        autoformat = true,
        completion = true,
        diagnostic = true,
        folding = true,
        references = true,
        rename = true,
        symbols = true
      },
    },
  });

  -- require('lspconfig').ruby_lsp.setup({
  --   cmd = { vim.fn.expand("~/.rbenv/shims/ruby-lsp") },
  --   root_dir = require('lspconfig').util.root_pattern("Gemfile", ".git", "."),
  --   init_options = {
  --     formatter = 'standard',
  --     linters = { 'standard' },
  --   },
  -- })
end

return M
