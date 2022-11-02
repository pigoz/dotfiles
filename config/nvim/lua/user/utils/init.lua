local M = {}

---Pretty print lua table
function M.dump(...)
  local objects = vim.tbl_map(vim.inspect, { ... })
  print(unpack(objects))
end

function M.deprecated(key)
  return ':echo "deprecated, please use «' .. key .. '» instead"<cr>'
end

function M.reload_config()
  for name, _ in pairs(package.loaded) do
    package.loaded[name] = nil
  end

  dofile(vim.env.MYVIMRC)
  vim.notify("nvim config reloaded!", vim.log.levels.INFO)
end

function M.cycle_buffer()
  -- M.dump(vim.api.nvim_tabpage_list_wins(0))
  vim.api.nvim_command('FocusSplitCycle')
end

function M.cycle_buffer_reverse()
  vim.api.nvim_command('FocusSplitCycle reverse')
end

return M
