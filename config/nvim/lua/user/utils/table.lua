local M = {}

function M.merge(a, b)
  local c = {}
  for k, v in pairs(a) do c[k] = v end
  for k, v in pairs(b) do c[k] = v end
  return c
end

function M.contains(t, element)
  for _, value in pairs(t) do
    if value == element then
      return true
    end
  end
  return false
end

function M.keys(tbl)
  local keys = {}
  for key, _ in pairs(tbl) do
    table.insert(keys, key)
  end
  return keys
end

function M.from_array(tbl, fn)
  local map = {}
  for _, n in ipairs(tbl) do
    local k, v = fn(n)
    map[k] = v
  end
  return map
end

return M
