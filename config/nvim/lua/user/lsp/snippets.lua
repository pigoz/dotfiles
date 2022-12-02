local M = {}

function M.setup()
  local ls = require("luasnip")
  local types = require("luasnip.util.types")

  ls.config.set_config {
    -- This tells LuaSnip to remember to keep around the last snippet.
    -- You can jump back into it even if you move outside of the selection
    history = true,

    -- This one is cool cause if you have dynamic snippets, it updates as you type!
    updateevents = "TextChanged,TextChangedI",

    -- Autosnippets:
    enable_autosnippets = true,

    -- Crazy highlights!!
    -- #vid3
    -- ext_opts = nil,
    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { " « ", "NonTest" } },
        },
      },
    },
  }

  vim.keymap.set({ "i", "s" }, "<c-k>", function()
    if ls.expand_or_jumpable() then
      ls.expand_or_jump()
    end
  end, { silent = true })

  -- <c-j> is my jump backwards key.
  -- this always moves to the previous item within the snippet
  vim.keymap.set({ "i", "s" }, "<c-j>", function()
    if ls.jumpable(-1) then
      ls.jump(-1)
    end
  end, { silent = true })

  -- <c-l> is selecting within a list of options.
  -- This is useful for choice nodes
  vim.keymap.set("i", "<c-l>", function()
    if ls.choice_active() then
      ls.change_choice(1)
    end
  end)

  print('loading vscode snippets...')

  require("luasnip/loaders/from_vscode").lazy_load({
    paths = vim.api.nvim_get_runtime_file("snippets", false)
  })
end

return M
