---Pretty print lua table
function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, { ... })
    print(unpack(objects))
end

function _G.mergetbl(a, b)
  local c = {}
  for k,v in pairs(a) do c[k] = v end
  for k,v in pairs(b) do c[k] = v end
  return c
end

function _G.deprecated(key)
  return ':echo "deprecated, please use «'.. key .. '» instead"<cr>'
end

local default_opts = { noremap = true, silent = true }

function _G.key(mode, key, action)
  local keymap = vim.api.nvim_set_keymap
  vim.api.nvim_set_keymap(mode, key, action, default_opts)
end

function _G.keyo(mode, key, action, given_opts)
  local opts = mergetbl(default_opts, given_opts)
  vim.api.nvim_set_keymap(mode, key, action, opts)
end

require('settings')
require('plugins')
require('keybindings')
