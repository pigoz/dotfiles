local M = {}

function M.read(file, amount)
  local fd = io.open(vim.fs.normalize(file), 'r')
  if fd == nil then
    return nil
  end
  local content = fd:read(amount or '*a')
  fd:close()
  return content
end

return M
