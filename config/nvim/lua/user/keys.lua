local u = require('user.utils')
local M = {}

function M.setup_which_key_bindings(wk)
  wk.register({
    ["<D-k>"] = { u.cycle_buffer, "focus split cycle" },
    ["<D-j>"] = { u.cycle_buffer_reverse, "focus split cycle (reverse)" },

    ["<leader>a"] = { vim.lsp.buf.code_action, "lsp line action" },

    ["<leader>c"] = {
      name = "+config",
      ['e'] = { ':e $MYVIMRC<cr>', 'edit' },
      ['r'] = { u.reload_config, 'reload' },
    },
    ["<leader>f"] = {
      name = '+find',
      f = { M.telescope_files, 'files' },
      b = { M.telescope_buffers, 'buffers' },
      h = { M.telescope_help, 'help tags' },
      g = { M.telescope_grep, 'grep files' },
      -- f = { 'za', 'fold toggle' },
      -- d = { 'zR', 'fold clear all' },
    },
    ["<leader>j"] = {
      name = '+lsp',
      ['q'] = { M.quickfix, 'quickfix' },
      ['k'] = { vim.lsp.buf.hover, 'show documentation' },
      ['a'] = { vim.lsp.buf.code_action, 'line action' },
      ['d'] = { vim.lsp.buf.definition, 'definition' },
      ['D'] = { vim.lsp.buf.declaration, 'declaration' },
      ['t'] = { vim.lsp.buf.type_definition, 'type definition' },
      ['f'] = { require('user.lsp.format').format, 'format' },
      -- ['g'] = { vim.lsp.buf.range_formatting, 'format ranGe' },
      ['i'] = { vim.lsp.buf.implementation, 'implementation' },
      ['n'] = { vim.diagnostic.goto_next, 'next diagnostic' },
      ['p'] = { vim.diagnostic.goto_prev, 'prev diagnostic' },
      ['l'] = { vim.lsp.codelens.display, 'code lens' },
      ['r'] = { vim.lsp.buf.rename, 'rename' },
      ['R'] = { vim.lsp.buf.references, 'references' },
    },
    ['<leader>d'] = {
      name = '+diagnostics',
      ['t'] = { ':TroubleToggle<cr>', 'toggle' },
      ['d'] = { ':TroubleToggle document_diagnostics<cr>', 'document' },
      ['w'] = { ':TroubleToggle workspace_diagnostics<cr>', 'workspace' },
      ['l'] = { ':TroubleToggle loclist<cr>', 'loclist' },
      ['q'] = { ':TroubleToggle quickfix<cr>', 'quickfix' },
      ['r'] = { ':TroubleToggle lsp_references<cr>', 'lsp references' },
    }
  })
end

function M.quickfix()
  vim.lsp.buf.code_action { only = 'quickfix' }
end

function M.setup_global_key_bindings()
  local set = vim.keymap.set
  set("n", "Q", "<Nop>") -- disable ex mode

  set("n", "<PageUp>", "<C-u>")
  set("n", "<PageDown>", "<C-d>")

  set("n", "<cr>", ":nohlsearch<cr>") -- remove highlights

  -- easier window navigation
  -- key("n", "<c-h>", "<c-w>h")
  -- key("n", "<c-j>", "<c-w>j")
  -- key("n", "<c-k>", "<c-w>k")
  -- key("n", "<c-l>", "<c-w>l")

  -- better visual-mode indentation
  set("v", "<", "<gv")
  set("v", ">", ">gv")

  set("n", "<D-d>", ":Neotree filesystem toggle left<cr>")
  set("n", "<D-f>", M.telescope_files)
  set("n", "<D-r>", M.telescope_grep)
  set("n", "<D-b>", M.telescope_buffers)
  set("n", "<D-t>", u.deprecated('LEADER-f or CMD-f'))
  set("n", "<D-g>", M.lazygit)
  set("n", "=", ":pop<cr>")

  set("i", "<D-d>", ":Neotree filesystem toggle left<cr>")
  set("i", "<D-f>", M.telescope_files)
  set("n", "<D-r>", M.telescope_grep)
  set("i", "<D-b>", M.telescope_buffers)
  set("i", "<D-t>", u.deprecated('LEADER-f or CMD-f'))

  set("n", "<c-w>h", u.deprecated("LEADER-j or ="))
  set("n", "<c-w>j", u.deprecated("LEADER-j or ="))
  set("n", "<c-w>k", u.deprecated("LEADER-j or ="))
  set("n", "<c-w>l", u.deprecated("LEADER-j or ="))

  -- macos mappings for casuals
  set({ "n", "i", "v", "c" }, '<D-s>', '<cmd>write<cr>')
  set({ "n", "i", "v", "c" }, '<D-a>', '<esc>ggVG')
  set("n", '<D-w>', '<C-W>q')

  -- copy
  set({ "n", "i", "v" }, '<D-c>', '"+y')

  -- cut
  set({ "n", "i", "v" }, '<D-x>', '"+d')

  -- paste (god this was hard)
  set("n", '<D-v>', '"*p')
  set("i", '<D-v>', '<C-o>"*p')
  set("c", '<D-v>', '<C-R>"')
  set("v", '<D-v>', '"_c<C-r><C-o>+') -- don't update *-register with selection
end

function M.setup_lsp_keybindings(_, bufnr)
  local set = vim.keymap.set
  local opt = { buffer = bufnr }
  set('n', 'K', vim.lsp.buf.hover, opt)
  set('n', 'gd', vim.lsp.buf.definition, opt)
  set('n', 'gt', vim.lsp.buf.type_definition, opt)
  set('n', 'gi', vim.lsp.buf.implementation, opt)
end

function M.telescope_files()
  require('telescope.builtin').find_files(
    require('telescope.themes').get_dropdown {
      prompt_title = "files",
      prompt_prefix = "🔍",
      previewer = false
    })
end

function M.telescope_grep()
  require('telescope.builtin').live_grep(
    require('telescope.themes').get_dropdown {
      prompt_title = "grep",
      prompt_prefix = "🔍",
      previewer = false
    })
end

function M.telescope_buffers()
  require('telescope.builtin').buffers(
    require('telescope.themes').get_dropdown {
      prompt_title = "buffers",
      prompt_prefix = "🔍",
      previewer = false
    })
end

function M.telescope_help()
  require('telescope.builtin').buffers(
    require('telescope.themes').get_dropdown {
      prompt_title = "help tags",
      prompt_prefix = "🔍",
      previewer = false
    })
end

function M.lazygit()
  vim.g.lazygit_use_custom_config_file_path = 1
  vim.g.lazygit_config_file_path = "~/Library/Application\\ Support/lazygit/config.yml"
  require('lazygit').lazygit()
end

return M
