-- OneDark / One Light with the contrast recalibrated for all-day reading,
-- following the macOS light/dark mode like iTerm2. Rationale in THEME.md
local M = {}

-- onedark.nvim palette overrides: same hues, only the lightness changed
local palettes = {
  dark = {
    fg = "#c9d1de",
    purple = "#e79cfe",
    green = "#99c57a",
    orange = "#e6ad79",
    blue = "#73bffd",
    yellow = "#e5c07b",
    cyan = "#66c6d2",
    red = "#fe9da1",
    grey = "#969dac",
    light_grey = "#a3abb8",
  },
  light = {
    fg = "#676a72",
    purple = "#b537b2",
    green = "#479847",
    orange = "#b57c0b",
    blue = "#4078f2",
    yellow = "#d7660b", -- types: One Light's dark yellow can't be saturated
    cyan = "#0184bc",
    red = "#e45649",
    grey = "#a4a5ac",
    light_grey = "#96999d",
  },
}

-- onedark.nvim uses grey for both comments and the UI chrome: comments get
-- their own level, listchars a fainter one
local levels = {
  dark = { comment = "#b1b8c7", invisible = "#787f8d" },
  light = { comment = "#87888d", invisible = "#c0c1c8" },
}

local function highlights(style)
  local comment = { fg = levels[style].comment }
  local invisible = { fg = levels[style].invisible }
  return {
    Comment = comment,
    SpecialComment = comment,
    ["@comment"] = comment,
    TSComment = comment,
    LspCodeLens = comment,
    NonText = invisible,
    Whitespace = invisible,
    SpecialKey = invisible,
  }
end

local function configure()
  local style = vim.o.background
  require("onedark").setup({
    style = style,
    code_style = { comments = "none" },
    colors = palettes[style],
    highlights = highlights(style),
  })
end

-- nvim-qt has no terminal to ask for its background, so read the mode
-- from macOS for both
local function system_background()
  local style = vim.fn.system({ "defaults", "read", "-g", "AppleInterfaceStyle" })
  return style:match("Dark") and "dark" or "light"
end

function M.setup()
  local group = vim.api.nvim_create_augroup("UserTheme", {})
  -- nvim reloads the colorscheme by itself when 'background' changes
  vim.api.nvim_create_autocmd("ColorSchemePre", {
    group = group,
    pattern = "onedark",
    callback = configure,
  })
  vim.o.background = system_background()
  vim.cmd.colorscheme("onedark")

  -- catch a light/dark switch made while nvim was open
  vim.api.nvim_create_autocmd("FocusGained", {
    group = group,
    callback = function()
      local style = system_background()
      if style ~= vim.o.background then
        vim.o.background = style
      end
    end,
  })
end

return M
