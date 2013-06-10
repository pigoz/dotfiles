highlight ColorColumn guibg=Black

if has("gui_macvim")
  macmenu &File.New\ Tab key=<nop>
  macmenu &Tools.Make key=<nop>
  map <D-b> :CtrlPBuffer<CR>
  imap <D-b> :CtrlPBuffer<CR>
  map <D-t> :CtrlP<CR>
  imap <D-t> :CtrlP<CR>
endif
