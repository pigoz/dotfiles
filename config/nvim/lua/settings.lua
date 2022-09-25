vim.g.loaded_netrw = true
vim.g.loaded_netrwPlugin = true
vim.g.netrw_nobeval = true

-- decrease update time
vim.o.timeoutlen = 500
vim.o.updatetime = 200

vim.o.termguicolors = true
vim.o.fileformat = 'unix'
vim.o.encoding="utf-8"

-- Use 2 spaces softtabs for everything except for languages where the
-- convention is 4spaces softtabs
vim.cmd([[
autocmd FileType * set ts=2 sw=2 sts=2 expandtab
autocmd FileType c,m,h,cpp,hpp,glsl,objc,python,php,swift,rust set ts=4 sw=4 sts=4 expandtab
autocmd FileType make set noexpandtab " make needs them tabs
autocmd FileType css set ft=scss
]])

-- editor ui
vim.o.number = true
vim.o.numberwidth = 3
vim.o.signcolumn = 'yes:2'
vim.o.cursorline = true

vim.o.list = true -- Activate listchars configuration
vim.opt.listchars = { tab = "▸·", eol = "¬", trail = "·" }
vim.o.cursorline = true -- Highlight current line
vim.o.ruler = true -- Show row / column
vim.o.showcmd = true -- Shows selection
vim.o.incsearch = true -- Use incremental search
vim.o.hlsearch = true -- Highlight search results

-- better splits
vim.o.splitbelow = true
vim.o.splitright = true

-- Makes neovim and host OS clipboard play nicely with each other
vim.o.virtualedit = 'all'
vim.o.clipboard = 'unnamedplus'

vim.o.foldenable = false -- Don't fold by default

-- Allow backgrounding buffers without writing them, and remember marks/undo
-- for backgrounded buffers
vim.o.hidden = true

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.colorcolumn = '80'

-- vim.o.winwidth = 83 -- 79(+4 for line numbers) fucks vim tree up
vim.o.cmdheight = 2 -- Command buffer height = 2

vim.o.title = true -- Change the terminal's title
vim.o.visualbell = true -- Don't beep
vim.o.errorbells = false -- Don't beep

vim.o.backup = false -- I use git anyway
vim.o.swapfile = false -- See previous line

-- set pastetoggle=<F2>     " Allows to enter 'paste mode'

vim.o.modeline = true
vim.o.modelines = 2

vim.o.scrolloff = 3 -- Number of lines to keep above and below the cursor
vim.o.history = 50 -- Remember 50 items in commandline history
-- vim.o.jumpoptions = 'view' -- Preserve view while jumping

-- Map <leader> to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Ignore these files when using CtrlP
vim.opt.wildignore:append {
-- Rails specific
'*/tmp/*','*/.sass_cache/*','*/vendor/assets/*','*/public/assets/*',
-- Python specific
'*.pyc*',
-- C specific
'*/build/*','*.d','*.o',
-- SCM specific
'*/.git/*','*/.hg/*','*/.svn/*',
-- JavaScript specific
'*/dist/*','*/node_modules/*'
}      
