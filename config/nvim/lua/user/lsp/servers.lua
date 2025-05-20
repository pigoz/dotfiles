local M = {}

function M.setup()
  local root_pattern = require('lspconfig').util.root_pattern;

  vim.lsp.config('lua_ls', {
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = {
            'vim',
            'require',
          },
        },
      },
    },
  })

  vim.lsp.config('yamlls', {
    settings = {
      yaml = {
        schemas = require('user.lsp.schemastore').yaml(),
        -- To use yamlls' built-in schemastore access:
        -- schemastore = { enable = true, url = "https://www.schemastore.org/api/json/catalog.json" },
        -- validation = true,
        -- hover = true,
        -- completion = true,
      }
    },
  })

  vim.lsp.config('jsonls', {
    settings = {
      json = {
        schemas = require('user.lsp.schemastore').json(),
        validate = { enable = true },
      },
    },
  })

  vim.lsp.config('emmet_ls', {
    filetypes = {
      'html', 'css', 'scss', 'less', 'sass', 'stylus',
      'javascriptreact', 'typescriptreact',
      'eruby', 'php', 'vue', 'svelte', 'astro', 'haml', 'pug',
    },
  })

  vim.lsp.config('rubocop', {
    cmd = { vim.fn.expand("~/.rbenv/shims/rubocop"), '--lsp' },
    filetypes = { 'ruby' },
    root_dir = root_pattern('Gemfile', '.git'),
  })

  vim.lsp.config('ruby_lsp', {
    cmd = { vim.fn.expand("~/.rbenv/shims/ruby-lsp") },
    filetypes = { 'ruby', 'eruby' },
    root_dir = root_pattern("Gemfile", ".git", ".ruby-lsp"),
    init_options = {},
  })

  vim.lsp.config('solargraph', {
    cmd = { vim.fn.expand("~/.rbenv/shims/solargraph"), 'stdio' },
    root_dir = root_pattern("Gemfile", ".git", "."),
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
  })

  vim.lsp.config('dprint', {
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
      "eruby",
      "lua"
    }
  })

  -- install language servers
  require("mason").setup({})

  require('mason-lspconfig').setup({
    ensure_installed = {
      'emmet_ls',
      'jsonls',
      'yamlls',
      'cssls',
      'lua_ls',
      'ts_ls'
    },
    automatic_installation = true
  })
end

return M
