local M = {}

function M.setup()
  require('user.lsp.servers').setup()
  require('user.lsp.completion').setup()
  require('user.lsp.cosmetics').setup()
  require('user.lsp.format').setup()
end

return M
