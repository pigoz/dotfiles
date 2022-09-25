local M = {}

---Pretty print lua table
function M.dump(...)
    local objects = vim.tbl_map(vim.inspect, { ... })
    print(unpack(objects))
end

function M.mergetbl(a, b)
  local c = {}
  for k,v in pairs(a) do c[k] = v end
  for k,v in pairs(b) do c[k] = v end
  return c
end

function M.deprecated(key)
  return ':echo "deprecated, please use «'.. key .. '» instead"<cr>'
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
  for name,_ in pairs(package.loaded) do
    package.loaded[name] = nil
  end

  dofile(vim.env.MYVIMRC)
  vim.notify("nvim config reloaded!", vim.log.levels.INFO)
end

function M.pick_window()
  require('nvim-window').pick()
end

function M.cmd(cmd)
  vim.cmd(cmd)
end

return M
