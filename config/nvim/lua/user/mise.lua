-- Tools come from mise (ruby, bun, lua-language-server, ...). There's no node
-- on this machine, so npm packages run under bun with bunx.
local M = {}

-- The shims pick each tool's version from the directory it runs in (a language
-- server's root dir), and work in neovim-qt started from the Dock too, which
-- doesn't get mise's PATH from zsh.
function M.setup()
  vim.env.PATH = vim.fn.expand('~/.local/share/mise/shims') .. ':' .. vim.env.PATH
end

-- cmd that runs an executable of an npm package with bun, fetching the package
-- into bunx's cache the first time
function M.bunx(package, cmd)
  return { 'bunx', '--bun', '-p', package, unpack(cmd) }
end

return M
