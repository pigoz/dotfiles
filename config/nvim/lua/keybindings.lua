local wk = require("which-key")
local u = require("utils")

wk.register({
  ["<D-k>"] = { u.cycle_buffer, "focus split cycle" },
  ["<D-j>"] = { u.cycle_buffer_reverse, "focus split cycle (reverse)" },
  [";"]     = { ":CtrlP<cr>", "CtrlP" },

  ['='] = { u.pick_window, "pick window" },

  ["<leader>a"] = { "<Plug>(coc-codeaction)", "lsp line action" },
  ["<leader>d"] = { "<Plug>(coc-definition)", "lsp definition" },
  ["<leader>y"] = { ":FocusSplitNicely<cr>", "focus split nicely" },
  ["<leader>h"] = { ":FocusSplitCycle<cr>", "focus split cycle" },
  ["<leader>j"] = { u.pick_window, "pick window" },

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
    ['.'] = { ':CocConfig'                          , 'config'},
    [';'] = { '<Plug>(coc-refactor)'                , 'refactor'},
    ['a'] = { '<Plug>(coc-codeaction)'              , 'line action'},
    ['A'] = { '<Plug>(coc-codeaction-selected)'     , 'selected action'},
    ['b'] = { ':CocNext'                            , 'next action'},
    ['B'] = { ':CocPrev'                            , 'prev action'},
    ['c'] = { ':CocList commands'                   , 'commands'},
    ['d'] = { '<Plug>(coc-definition)'              , 'definition'},
    ['D'] = { '<Plug>(coc-declaration)'             , 'declaration'},
    ['e'] = { ':CocList extensions'                 , 'extensions'},
    ['f'] = { '<Plug>(coc-format-selected)'         , 'format selected'},
    ['F'] = { '<Plug>(coc-format)'                  , 'format'},
    ['h'] = { '<Plug>(coc-float-hide)'              , 'hide'},
    ['i'] = { '<Plug>(coc-implementation)'          , 'implementation'},
    ['I'] = { ':CocList diagnostics'                , 'diagnostics'},
    ['j'] = { '<Plug>(coc-float-jump)'              , 'float jump'},
    ['l'] = { '<Plug>(coc-codelens-action)'         , 'code lens'},
    ['n'] = { '<Plug>(coc-diagnostic-next)'         , 'next diagnostic'},
    ['N'] = { '<Plug>(coc-diagnostic-next-error)'   , 'next error'},
    ['o'] = { '<Plug>(coc-openlink)'                , 'open link'},
    ['O'] = { ':CocList outline'                    , 'outline'},
    ['p'] = { '<Plug>(coc-diagnostic-prev)'         , 'prev diagnostic'},
    ['P'] = { '<Plug>(coc-diagnostic-prev-error)'   , 'prev error'},
    ['q'] = { '<Plug>(coc-fix-current)'             , 'quickfix'},
    ['r'] = { '<Plug>(coc-rename)'                  , 'rename'},
    ['R'] = { '<Plug>(coc-references)'              , 'references'},
    ['s'] = { ':CocList -I symbols'                 , 'references'},
    ['S'] = { ':CocList snippets'                   , 'snippets'},
    ['t'] = { '<Plug>(coc-type-definition)'         , 'type definition'},
    ['u'] = { ':CocListResume'                      , 'resume list'},
    ['U'] = { ':CocUpdate'                          , 'update CoC'},
    ['v'] = { ':Vista!!'                            , 'tag viewer'},
    ['z'] = { ':CocDisable'                         , 'disable CoC'},
    ['Z'] = { ':CocEnable'                          , 'enable CoC'},
  },
})

vim.cmd([[
inoremap <silent><expr> <D-f> coc#refresh()
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
]])

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

u.key("n", "<D-d>", ":NvimTreeToggle<cr>")
u.key("n", "<D-f>", ":CtrlP<cr>")
u.key("n", "<D-b>", ":CtrlPBuffer<cr>")
u.key("n", "<D-t>", u.deprecated('LEADER-f or CMD-f'))

u.key("i", "<D-d>", ":NvimTreeToggle<cr>")
u.key("i", "<D-f>", ":CtrlP<cr>")
u.key("i", "<D-b>", ":CtrlPBuffer<cr>")
u.key("i", "<D-t>", u.deprecated('LEADER-f or CMD-f'))

u.key("n", "<c-w>h", u.deprecated("LEADER-j or ="))
u.key("n", "<c-w>j", u.deprecated("LEADER-j or ="))
u.key("n", "<c-w>k", u.deprecated("LEADER-j or ="))
u.key("n", "<c-w>l", u.deprecated("LEADER-j or ="))
