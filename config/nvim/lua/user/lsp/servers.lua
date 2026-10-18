local mise = require('user.mise')

local M = {}

-- servers that are npm packages, run with lspconfig's (or lsp/'s) cmd
local npm = {
  emmet_ls = 'emmet-ls',
  jsonls = 'vscode-langservers-extracted',
  cssls = 'vscode-langservers-extracted',
  yamlls = 'yaml-language-server',
  tsgo = 'typescript@7',
}

-- the others come from mise (see ~/.config/mise/config.toml and ~/.default-gems)
function M.setup()
  for name, package in pairs(npm) do
    vim.lsp.config(name, { cmd = mise.bunx(package, vim.lsp.config[name].cmd) })
    vim.lsp.enable(name)
  end

  local lsp_config_dir = vim.fn.stdpath('config') .. '/lsp'

  for name, type in vim.fs.dir(lsp_config_dir) do
    if type == 'file' and name:match('%.lua$') then
      vim.lsp.enable(name:gsub('%.lua$', ''))
    end
  end
end

return M
