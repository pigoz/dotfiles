-- onedarkpro.nvim as it comes, OneDark or One Light following the macOS
-- light/dark mode like iTerm2. Rationale in THEME.md
local M = {}

-- nvim-qt has no terminal to ask for its background, so read the mode
-- from macOS for both
local function system_background()
  local style = vim.fn.system({ "defaults", "read", "-g", "AppleInterfaceStyle" })
  return style:match("Dark") and "dark" or "light"
end

local themes = { dark = "onedark", light = "onelight" }

local function apply(style)
  -- onedarkpro doesn't set it, and setting it reloads the current colorscheme
  vim.o.background = style
  vim.cmd.colorscheme(themes[style])
end

function M.setup()
  apply(system_background())

  -- catch a light/dark switch made while nvim was open
  vim.api.nvim_create_autocmd("FocusGained", {
    group = vim.api.nvim_create_augroup("UserTheme", {}),
    callback = function()
      local style = system_background()
      if vim.g.colors_name == themes[vim.o.background] and style ~= vim.o.background then
        apply(style)
      end
    end,
  })
end

return M
