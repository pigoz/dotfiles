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
  local group = vim.api.nvim_create_augroup("LspFormat", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = require('user.utils.table').keys(M._config.client_whitelist),
    callback = function()
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = group,
        pattern = "*",
        callback = function() require('user.lsp.format').format() end
      })
    end
  })
end

return M