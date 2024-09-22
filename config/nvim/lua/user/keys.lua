local u = require('user.utils')
local M = {}

function M.setup_which_key_bindings(wk)
  wk.add({
    { "<D-k>", u.cycle_buffer, desc = "focus split cycle" },
    { "<D-j>", u.cycle_buffer_reverse, desc = "focus split cycle (reverse)" },

    {"<leader>a", vim.lsp.buf.code_action, desc = "lsp line action" },

    {"<leader>c", group = "config" },
    {"<leader>ce", ':e $MYVIMRC<cr>', desc = 'edit' },
    {"<leader>cr", u.reload_config, desc = 'reload' },

    {"<leader>f", group = "find" },
    {"<leader>ff", M.telescope_files, desc = 'files' },
    {"<leader>fb", M.telescope_buffers, desc = 'buffers' },
    {"<leader>fh", M.telescope_help, desc = 'help tags' },
    {"<leader>fg", M.telescope_grep, desc = 'grep files' },

    {"<leader>j", group = "lsp" },
    {"<leader>jq", M.quickfix, desc = 'quickfix' },
    {"<leader>jk", vim.lsp.buf.hover, desc = 'show documentation' },
    {"<leader>ja", vim.lsp.buf.code_action, desc = 'line action' },
    {"<leader>jd", vim.lsp.buf.definition, desc = 'definition' },
    {"<leader>jD", vim.lsp.buf.declaration, desc = 'declaration' },
    {"<leader>jt", vim.lsp.buf.type_definition, desc = 'type definition' },
    {"<leader>jf", require('user.lsp.format').format, desc = 'format' },
    {"<leader>jg", vim.lsp.buf.range_formatting, desc = 'format ranGe' },
    {"<leader>ji", vim.lsp.buf.implementation, desc = 'implementation' },
    {"<leader>jn", vim.diagnostic.goto_next, desc = 'next diagnostic' },
    {"<leader>jp", vim.diagnostic.goto_prev, desc = 'prev diagnostic' },
    {"<leader>jl", vim.lsp.codelens.display, desc = 'code lens' },
    {"<leader>jr", vim.lsp.buf.rename, desc = 'rename' },
    {"<leader>jR", vim.lsp.buf.references, desc = 'references' },

    {"<leader>d", group = "diagnostics" },
    {"<leader>dt", ':TroubleToggle<cr>', desc = 'toggle' },
    {"<leader>dd", ':TroubleToggle document_diagnostics<cr>', desc = 'document' },
    {"<leader>dw", ':TroubleToggle workspace_diagnostics<cr>', desc = 'workspace' },
    {"<leader>dl", ':TroubleToggle loclist<cr>', desc = 'loclist' },
    {"<leader>dq", ':TroubleToggle quickfix<cr>', desc = 'quickfix' },
    {"<leader>dr", ':TroubleToggle lsp_references<cr>', desc = 'lsp references' },

    {"<leader>h", group = "terminal" },
    {"<leader>ht",  M.run_tests, desc = 'run project tests' }
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

  set("n", "<D-d>", ":Neotree filesystem toggle float<cr>")
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

  -- paste (god this was very, VERY hard)
  set("n", '<D-v>', '"+p')
  set("i", '<D-v>', '<C-R><C-P>+')
  set("c", '<D-v>', '<C-R>+')
  set("v", '<D-v>', '"_c<C-r><C-o>+') -- don't update *-register with selection

  -- handle URLs
  if vim.fn.has("mac") == 1 then
    set('n', 'gx', '<Cmd>call jobstart(["open", expand("<cfile>")], {"detach": v:true})<CR>')
  elseif vim.fn.has("unix") == 1 then
    set('n', 'gx', '<Cmd>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<CR>')
  end
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
  vim.cmd(':FloatermNew --name=lazygit lazygit')
end

function M.run_tests()
  -- XXX support multiple languages, current lines and file
  vim.cmd(':FloatermNew --name=tests --autoclose=0 --autoinsert=false --wintype=split npm test')
end

return M
