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

function M.trash(path)
  local script = string.format(
    'tell application "Finder" to move POSIX file "%s" to trash',
    vim.fn.fnamemodify(vim.fn.fnameescape(path), ":p"))

  vim.fn.system { "osascript", "-e", script }
end

return M
