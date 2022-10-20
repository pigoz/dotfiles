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
  -- D-k starts autocompletion
  u.keye('i', '<D-k>', 'coc#refresh()')
  -- enter selects current item
  u.key('i', '<CR>', M.coc_confirm { or_send = "\\<CR>" })

  u.key("n", "Q", "<Nop>") -- disable ex mode

  u.key("n", "<PageUp>", "<C-u>")
  u.key("n", "<PageDown>", "<C-d>")

  u.key("n", "<cr>", ":nohlsearch<cr>") -- remove highlights

  -- easier window navigation
  -- key("n", "<c-h>", "<c-w>h")
  -- key("n", "<c-j>", "<c-w>j")
  -- key("n", "<c-k>", "<c-w>k")
  -- key("n", "<c-l>", "<c-w>l")

  -- better visual-mode indentation
  u.key("v", "<", "<gv")
  u.key("v", ">", ">gv")

  u.key("n", "<D-d>", ":Neotree filesystem toggle left<cr>")
  u.key("n", "<D-f>", M.telescope_git_files)
  u.key("n", "<D-b>", M.telescope_buffers)
  u.key("n", "<D-t>", u.deprecated('LEADER-f or CMD-f'))

  u.key("i", "<D-d>", ":Neotree filesystem toggle left<cr>")
  u.key("i", "<D-f>", M.telescope_git_files)
  u.key("i", "<D-b>", M.telescope_buffers)
  u.key("i", "<D-t>", u.deprecated('LEADER-f or CMD-f'))

  u.key("n", "<c-w>h", u.deprecated("LEADER-j or ="))
  u.key("n", "<c-w>j", u.deprecated("LEADER-j or ="))
  u.key("n", "<c-w>k", u.deprecated("LEADER-j or ="))
  u.key("n", "<c-w>l", u.deprecated("LEADER-j or ="))
end

function M.telescope_git_files()
  require('telescope.builtin').git_files(
    require('telescope.themes').get_dropdown {
      prompt_title = "git files",
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

function M.coc_confirm(opt)
  return function()
    if vim.fn['coc#pum#visible']() then
      vim.fn['coc#pum#confirm']()
    else
      vim.fn.feedkeys(opt.or_send, 'in')
    end
  end
end

function M.coc_documentation()
  if vim.fn.CocAction('hasProvider', 'hover') then
    vim.fn.CocActionAsync('doHover')
  end
end

return M
