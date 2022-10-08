local M = {}

local function packer_install()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local function prequire(module_name, fn)
  local status_ok, mod = pcall(require, module_name)
  if not status_ok then
    local msg = "couldn't require '" .. module_name .. "'"
    vim.notify(msg, vim.log.levels.ERROR)
    return
  end
  return fn(mod)
end

function M.setup(callback)
  local packer_bootstrap = packer_install()

  -- reload neovim whenever plugins.lua is saved
  vim.cmd([[
    augroup packer_user_config
      autocmd!
      autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
  ]])

  return prequire('packer', function(packer)
    -- run packer in a popup window
    packer.init({
      display = {
        open_fn = function()
          return require('packer.util').float({ border = 'single' })
        end
      }
    })

    return packer.startup(function(use)
      local result = callback(use)

      if packer_bootstrap then
        packer.sync()
      end

      return result
    end)
  end)
end

return M
