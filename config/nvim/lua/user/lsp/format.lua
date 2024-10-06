local M = {}

M._config = {
  autosave = {
    'lua',
    'typescript',
    'javascript',
    'typescriptreact',
    'typescript.jsx',
    'css',
    'scss',
    'json',
    'yaml',
    'html',
    'ruby',
    'erbuy'
  },
  overrides = {
    ['lua'] = 'sumneko_lua',
    ['ruby'] = 'rubocop',
  },
  default = 'dprint',
}

function M.format(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      local config = require('user.lsp.format')._config;
      local wl_client_name = config.overrides[vim.bo.filetype] or config.default
      return wl_client_name == client.name
    end,
    bufnr = bufnr or vim.api.nvim_get_current_buf(),
  })
end

function M.setup()
  local group = vim.api.nvim_create_augroup("LspFormat", { clear = true })
  local patterns = M._config.autosave
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = patterns,
    callback = function(tbl)
      -- local filetype = tbl.match i.e.: lua
      local bufnr = tbl.buf
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function() require('user.lsp.format').format(bufnr) end
      })
    end
  })
end

return M
