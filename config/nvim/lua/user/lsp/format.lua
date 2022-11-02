local M = {}

M._config = {
  client_whitelist = {
    ['lua'] = 'sumneko_lua',
    ['typescript'] = 'null-ls', -- prettier
    ['typescriptreact'] = 'null-ls',
    ['typescript.jsx'] = 'null-ls',
    ['css'] = 'null-ls', -- prettier
  }
}

function M.format(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      local config = require('user.lsp.format')._config
      local wl_client_name = config.client_whitelist[vim.bo.filetype]
      return wl_client_name == client.name
    end,
    bufnr = bufnr or vim.api.nvim_get_current_buf(),
  })
end

function M.setup()
  -- auto format on save
  vim.cmd [[autocmd BufWritePre * lua require('user.lsp.format').format()]]
end

return M
