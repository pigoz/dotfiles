local M = {}

function M.nvm_lookup_alias(name)
  local read = require('user.utils.io').read
  return read(string.format('~/.nvm/alias/%s', name), '*l')
end

function M.nvm_default_version()
  return M.nvm_lookup_alias('default')
end

function M.nvm_bin_path()
  local version = M.nvm_default_version()
  if version then
    local path = string.format('~/.nvm/versions/node/%s/bin', version)
    return vim.fs.normalize(path)
  end
end

function M.append_nvm_bin_path()
  local path = M.nvm_bin_path()
  if path then
    vim.opt.path:append(path)
  else
    vim.notify(
      [[user.utils.lua: couldn't get NVM bin path]],
      vim.log.levels.WARN)
  end
end

return M
