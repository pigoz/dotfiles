local u = require('user.utils')
local M = {}

function M.setup_which_key_bindings(wk)
  wk.register({
    ["<D-k>"] = { u.cycle_buffer, "focus split cycle" },
    ["<D-j>"] = { u.cycle_buffer_reverse, "focus split cycle (reverse)" },
    ['='] = { u.pick_window, "pick window" },

    ["<leader>a"] = { "<Plug>(coc-codeaction)", "lsp line action" },
    ["<leader>k"] = { M.coc_documentation, "lsp show documentation" },
    ["<leader>j"] = { "<Plug>(coc-definition)", "lsp jump definition" },
    ["<leader>g"] = { ":LazyGit<cr>", "lazygit" },

    ["<leader>c"] = {
      name = "+config",
      ['e'] = { ':e $MYVIMRC<cr>', 'edit' },
      ['r'] = { u.reload_config, 'reload' },
    },
    -- ["<leader>f"] = {
    --   name = '+fold',
    --   f = { 'za', 'fold toggle' },
    --   d = { 'zR', 'fold clear all' },
    -- },
    ["<leader>l"] = {
      name = '+lsp',
      ['.'] = { ':CocConfig<cr>', 'config' },
      [';'] = { '<Plug>(coc-refactor)', 'refactor' },
      ['a'] = { '<Plug>(coc-codeaction)', 'line action' },
      ['A'] = { '<Plug>(coc-codeaction-selected)', 'selected action' },
      ['b'] = { ':CocNext<cr>', 'next action' },
      ['B'] = { ':CocPrev<cr>', 'prev action' },
      ['c'] = { ':CocList commands<cr>', 'commands' },
      ['d'] = { '<Plug>(coc-definition)', 'definition' },
      ['D'] = { '<Plug>(coc-declaration)', 'declaration' },
      ['e'] = { ':CocList extensions<cr>', 'extensions' },
      ['f'] = { '<Plug>(coc-format-selected)', 'format selected' },
      ['F'] = { '<Plug>(coc-format)', 'format' },
      ['h'] = { '<Plug>(coc-float-hide)', 'hide' },
      ['i'] = { '<Plug>(coc-implementation)', 'implementation' },
      ['I'] = { ':CocList diagnostics<cr>', 'diagnostics' },
      ['j'] = { '<Plug>(coc-float-jump)', 'float jump' },
      ['k'] = { M.coc_documentation, 'show documentation' },
      ['l'] = { '<Plug>(coc-codelens-action)', 'code lens' },
      ['n'] = { '<Plug>(coc-diagnostic-next)', 'next diagnostic' },
      ['N'] = { '<Plug>(coc-diagnostic-next-error)', 'next error' },
      ['o'] = { '<Plug>(coc-openlink)', 'open link' },
      ['O'] = { ':CocList outline<cr>', 'outline' },
      ['p'] = { '<Plug>(coc-diagnostic-prev)', 'prev diagnostic' },
      ['P'] = { '<Plug>(coc-diagnostic-prev-error)', 'prev error' },
      ['q'] = { '<Plug>(coc-fix-current)', 'quickfix' },
      ['r'] = { '<Plug>(coc-rename)', 'rename' },
      ['R'] = { '<Plug>(coc-references)', 'references' },
      ['s'] = { ':CocList -I symbols<cr>', 'references' },
      ['S'] = { ':CocList snippets<cr>', 'snippets' },
      ['t'] = { '<Plug>(coc-type-definition)', 'type definition' },
      ['u'] = { ':CocListResume<cr>', 'resume list' },
      ['U'] = { ':CocUpdate<cr>', 'update CoC' },
      ['v'] = { ':Vista!!<cr>', 'tag viewer' },
      ['z'] = { ':CocDisable<cr>', 'disable CoC' },
      ['Z'] = { ':CocEnable<cr>', 'enable CoC' },
    },
  })
end

function M.setup_global_key_bindings()
  local set = vim.keymap.set
  local expr = { expr = true }
  -- D-k starts autocompletion
  set('i', '<D-k>', 'coc#refresh()', expr)

  -- CR selects current item is coc completion is visible, otherwise send CR
  set('i', '<CR>', 'coc#pum#visible() ? coc#pum#confirm() : "\\<CR>""', expr)

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
  set("n", "<D-g>", ":LazyGit<cr>")

  set("i", "<D-d>", ":Neotree filesystem toggle left<cr>")
  set("i", "<D-f>", M.telescope_files)
  set("n", "<D-r>", M.telescope_grep)
  set("i", "<D-b>", M.telescope_buffers)
  set("i", "<D-t>", u.deprecated('LEADER-f or CMD-f'))

  set("n", "<c-w>h", u.deprecated("LEADER-j or ="))
  set("n", "<c-w>j", u.deprecated("LEADER-j or ="))
  set("n", "<c-w>k", u.deprecated("LEADER-j or ="))
  set("n", "<c-w>l", u.deprecated("LEADER-j or ="))
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

function M.coc_documentation()
  if vim.fn.CocAction('hasProvider', 'hover') then
    vim.fn.CocActionAsync('doHover')
  end
end

return M
