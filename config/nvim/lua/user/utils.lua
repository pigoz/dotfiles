local M = {}

---Pretty print lua table
function M.dump(...)
  local objects = vim.tbl_map(vim.inspect, { ... })
  print(unpack(objects))
end

function M.mergetbl(a, b)
  local c = {}
  for k, v in pairs(a) do c[k] = v end
  for k, v in pairs(b) do c[k] = v end
  return c
end

function M.deprecated(key)
  return ':echo "deprecated, please use «' .. key .. '» instead"<cr>'
end

local default_opts = { noremap = true, silent = true }

function M.key(mode, key, action)
  vim.api.nvim_set_keymap(mode, key, action, default_opts)
end

function M.keyo(mode, key, action, given_opts)
  local opts = M.mergetbl(default_opts, given_opts)
  vim.api.nvim_set_keymap(mode, key, action, opts)
end

function M.reload_config()
  for name, _ in pairs(package.loaded) do
    package.loaded[name] = nil
  end

  dofile(vim.env.MYVIMRC)
  vim.notify("nvim config reloaded!", vim.log.levels.INFO)
end

function M.pick_window()
  require('nvim-window').pick()
end

function M.cycle_buffer()
  -- M.dump(vim.api.nvim_tabpage_list_wins(0))
  vim.api.nvim_command('FocusSplitCycle')
end

function M.cycle_buffer_reverse()
  vim.api.nvim_command('FocusSplitCycle reverse')
end

function M.packer_install()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

function M.packer_init(fn)
  -- reload neovim whenever plugins.lua is saved
  vim.cmd([[
    augroup packer_user_config
      autocmd!
      autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
  ]])

  return M.prequire('packer', function(packer)
    -- run packer in a popup window
    packer.init({
      display = {
        open_fn = function()
          return require('packer.util').float({ border = 'single' })
        end
      }
    })

    return packer.startup(function(use) return fn(packer, use) end)
  end)
end

function M.prequire(module_name, fn)
  local status_ok, mod = pcall(require, module_name)
  if not status_ok then
    local msg = "couldn't require '" .. module_name .. "'"
    vim.notify(msg, vim.log.levels.ERROR)
    return
  end
  return fn(mod)
end

return M
