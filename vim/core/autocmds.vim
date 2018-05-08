augroup coreAutocmd
	autocmd!

" Nvim terminal emulator {{{
	" when in a neovim terminal, add a buffer to the existing vim session
	" instead of nesting (credit justinmk)
	autocmd VimEnter * if !empty($NVIM_LISTEN_ADDRESS) && $NVIM_LISTEN_ADDRESS !=# v:servername
		\ |let g:r=jobstart(['nc', '-U', $NVIM_LISTEN_ADDRESS],{'rpc':v:true})
		\ |let g:f=fnameescape(expand('%:p'))
		\ |noau bwipe
		\ |call rpcrequest(g:r, "nvim_command", "edit ".g:f)
		\ |call rpcrequest(g:r, "nvim_command", "call corelib#SetNumberDisplay()")
		\ |qa
		\ |endif

	" enter insert mode whenever we go in a terminal buffer
  " Disable ATM ugly with current tab navigation
	" autocmd TermOpen,BufWinEnter,BufEnter term://* startinsert

	" turn numbers on for normal buffers; turn them off for terminal buffers
	autocmd TermOpen,BufWinEnter * call corelib#SetNumberDisplay()
"}}}

augroup END
