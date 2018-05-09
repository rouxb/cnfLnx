" Custom tabnr display that include the fixTabNameForLayer
" Rely on user variable g:fixTabNameForLayer which is a dict that
" contains the layer name for each tabnumber

scriptencoding utf-8

function! airline#extensions#tabline#formatters#customTabnr#format(tab_nr_type, nr)
  if a:tab_nr_type == 0 " nr of splits
    return (g:airline_symbols.space).g:fixTabNameForLayer[a:nr].'['.'%{len(tabpagebuflist('.a:nr.'))}'.']'
  elseif a:tab_nr_type == 1 " tab number
    return (g:airline_symbols.space).a:nr. ':' .(g:airline_symbols.space).g:fixTabNameForLayer[a:nr]
  else " a:tab_nr_type == 2 " splits and tab number
    return (g:airline_symbols.space).a:nr. ':' .(g:airline_symbols.space).g:fixTabNameForLayer[a:nr].'['.'%{len(tabpagebuflist('.a:nr.'))}'.']'
  endif
endfunction
