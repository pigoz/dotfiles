local M = {}

function M.setup()
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

  local lsp_config_dir = vim.fn.stdpath('config') .. '/lsp'

  for name, type in vim.fs.dir(lsp_config_dir) do
    if type == 'file' and name:match('%.lua$') then
      vim.lsp.enable(name:gsub('%.lua$', ''))
    end
  end
end

return M
