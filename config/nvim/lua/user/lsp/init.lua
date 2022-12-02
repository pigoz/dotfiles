local M = {}

function M.setup()
  require('user.lsp.servers').setup()
  require('user.lsp.completion').setup()
  require('user.lsp.cosmetics').setup()
  require('user.lsp.format').setup()
  require('user.lsp.snippets').setup()
end

return M
