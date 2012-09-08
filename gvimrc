highlight ColorColumn guibg=Black

if has("gui_macvim")
  macmenu &File.New\ Tab key=<nop>
  map <D-t> :CtrlP<CR>
  imap <D-t> :CtrlP<CR>
endif
