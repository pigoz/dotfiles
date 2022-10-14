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
  vim.keymap.set(mode, key, action, default_opts)
end

function M.keye(mode, key, action)
  vim.keymap.set(mode, key, action, M.mergetbl(default_opts, { expr = true }))
end

function M.keyo(mode, key, action, given_opts)
  local opts = M.mergetbl(default_opts, given_opts)
  vim.keymap.set(mode, key, action, opts)
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

return M
