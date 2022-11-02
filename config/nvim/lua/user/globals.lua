local ok, plenary_reload = pcall(require, "plenary.reload")

if not ok then
  RELOAD = require
else
  RELOAD = plenary_reload.reload_module
end

P = function(v)
  print(vim.inspect(v))
  return v
end

R = function(name)
  RELOAD(name)
  return require(name)
end
