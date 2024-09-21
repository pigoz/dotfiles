local M = {}

M._config = {
  client_whitelist = {
    ['lua'] = 'sumneko_lua',
    -- prettier
    ['typescript'] = 'null-ls',
    ['javascript'] = 'null-ls',
    ['typescriptreact'] = 'null-ls',
    ['typescript.jsx'] = 'null-ls',
    ['css'] = 'null-ls',
    ['json'] = 'null-ls',
    ['yaml'] = 'null-ls',
    ['html'] = 'null-ls',
    ['ruby'] = 'null-ls',
    ['eruby'] = 'null-ls',
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
  local patterns = require('user.utils.table').keys(M._config.client_whitelist)
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
