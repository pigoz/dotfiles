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

  require('lazy').setup(table, {
    performance = {
      rtp = {
        -- lazy resets the runtimepath, which drops neovim-qt's runtime and
        -- with it :GuiFont & co., so ginit.vim couldn't set the font
        paths = vim.tbl_filter(function(path)
          return path:match('nvim%-qt') ~= nil
        end, vim.opt.rtp:get()),
      },
    },
  })
end

return M
