local M = {}

function M.setup()
  -- setup cosmetics
  require('trouble').setup()

  local icons = {
    Error = "",
    Warn = "",
    Info = "",
    Hint = "",
  }

  local icons_diagnostic = {
    [vim.diagnostic.severity.ERROR] = icons.Error,
    [vim.diagnostic.severity.WARN] = icons.Warn,
    [vim.diagnostic.severity.INFO] = icons.Info,
    [vim.diagnostic.severity.HINT] = icons.Hint,
  }

  for severity, text in pairs(icons) do
    local name = 'DiagnosticSign' .. severity
    vim.fn.sign_define(name, {
      texthl = name,
      text = text,
      numhl = ""
    })
  end

  local function virtual_text_format(diagnostic)
    local icon = icons_diagnostic[diagnostic.severity]
    return string.format(
      '%s %s: %s [%s]',
      icon,
      diagnostic.code,
      diagnostic.message,
      diagnostic.source
    )
  end

  local conf = {
    virtual_text = {
      prefix = '',
      spacing = 2,
      source = false,
      format = virtual_text_format,
    },
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focus = false,
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(conf)
end

return M
