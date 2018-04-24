" corelib functions {{{
"

function! corelib#SetNumberDisplay() "{{{
" Varies the display of numbers.
"
" This is not a 'mode' specific setting, so a simple autocommand won't work.
" Numbers should not show up in a terminal buffer, regardless of if that
" buffer is in terminal mode or not.
	let l:buffername = @%
	
	if l:buffername =~ 'term://*'
		setlocal nonumber
		setlocal norelativenumber
		" setlocal scrolloff=0
	else
		setlocal number
		setlocal relativenumber
		" setlocal scrolloff=10
	endif
endfunction "}}}

"}}}
