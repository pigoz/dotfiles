local M = {}

local function lazy_install()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
  end

  vim.opt.rtp:prepend(lazypath)
end

function M.setup(table)
  lazy_install()

  vim.cmd([[
    augroup lazy_user_config
      autocmd!
      autocmd BufWritePost plugins.lua source <afile> | Lazy sync
    augroup end
  ]])

  require('lazy').setup(table)
end

return M
