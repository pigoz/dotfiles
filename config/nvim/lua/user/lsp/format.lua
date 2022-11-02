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

function M.setup()
  -- auto format on save
  vim.cmd [[autocmd BufWritePre * lua require('user.lsp.format').format()]]
end

return M
