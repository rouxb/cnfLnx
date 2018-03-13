""" Nvim core mappings structure
" Define main shortcut for global command,
" navigation in windows, tabs, file mgmt ...
" Define main navigation and file mgmt shortcuts.

" mappings {{{
  " map container
  let g:lmap = {}
  let g:mlmap = {}

    " windows management {{{
    " functions {{{
    " }}}

    " mappings {{{
      " native remap
      nnoremap <Plug>(window_h) <C-W>h
      nnoremap <Plug>(window_l) <C-W>l
      nnoremap <Plug>(window_j) <C-W>j
      nnoremap <Plug>(window_k) <C-W>k

      nnoremap <Plug>(window_b) <C-W>=
      nnoremap <Plug>(window_rh) <C-W>5>
      nnoremap <Plug>(window_rl) <C-W>5<
      nnoremap <Plug>(window_rj) :resize +5<CR>
      nnoremap <Plug>(window_rk) :resize -5<CR>

      nnoremap <Plug>(window_w) <C-W>w
      nnoremap <Plug>(window_r) <C-W>r
      nnoremap <Plug>(window_d) <C-W>c
      nnoremap <Plug>(window_q) <C-W>q
      nnoremap <Plug>(window_s1) <C-W>s
      nnoremap <Plug>(window_s2) <C-W>s
      nnoremap <Plug>(window_v1) <C-W>v
      nnoremap <Plug>(window_v2) <C-W>v
      nnoremap <Plug>(window_2) <C-W>v

    " leaderGuide map
    let g:lmap.w = { 'name' : '+windows' }
      " split
      let g:lmap.w.s = ['split', 'split-window-above']
      let g:lmap.w.v = ['vsplit', 'split-window-right']
      " move selection
      let g:lmap.w.h = ['call feedkeys("\<Plug>(window_w)")', 'select-left-window']
      let g:lmap.w.l = ['call feedkeys("\<Plug>(window_l)")', 'select-right-window']
      let g:lmap.w.j = ['call feedkeys("\<Plug>(window_j)")', 'select-down-window']
      let g:lmap.w.k = ['call feedkeys("\<Plug>(window_k)")', 'select-up-window']
    " move windows
    " resize windows
    let g:lmap.w['='] = ['call feedkeys("\<Plug>(window_b)")', 'balance-window']
    let g:lmap.w.r = { 
        \'name' : '+resize',
        \ '=' : ['call feedkeys("\<Plug>(window_b)")', 'balance-window'],
        \ 'h' : ['call feedkeys("\<Plug>(window_rh)")', 'expand-left'],
        \ 'l' : ['call feedkeys("\<Plug>(window_rl)")', 'expand-right'],
        \ 'j' : ['call feedkeys("\<Plug>(window_rj)")', 'expand-below'],
        \ 'k' : ['call feedkeys("\<Plug>(window_rk)")', 'expand-above']}
    " }}}

    " }}}

    " tabs management {{{
    " functions {{{
    " }}}

    " mappings {{{
    " }}}

    " }}}

    " buffer management {{{
    " functions {{{
    " }}}

    " mappings {{{
    let g:lmap.b = { 'name' : '+buffers' }
    " buffer mvmt
    let g:lmap.b.p = ['bprevious', 'previous-buffer']
    let g:lmap.b.n = ['bnext', 'next-buffer']
    let g:lmap.b.f = ['bfirst', 'first-buffer']
    let g:lmap.b.l = ['blast', 'last-buffer']
    let g:lmap.b.1 = ['b1', 'buffer-1']
    let g:lmap.b.2 = ['b2', 'buffer-2']
    let g:lmap.b.3 = ['b3', 'buffer-3']
    let g:lmap.b.4 = ['b4', 'buffer-4']
    let g:lmap.b.5 = ['b5', 'buffer-5']
    let g:lmap.b.6 = ['b6', 'buffer-6']
    let g:lmap.b.7 = ['b7', 'buffer-7']
    let g:lmap.b.8 = ['b8', 'buffer-8']
    let g:lmap.b.9 = ['b9', 'buffer-9']
    " buffer mgmt
    let g:lmap.b.k = ['bw', 'save&kill-buffer']
    let g:lmap.b.d = ['bw', 'delete-buffer']
    let g:lmap.b.b = ['', 'TODO-helm maps']
    " }}}

    " }}}

    " configure Leader guide {{{
    " functions {{{
    function! s:my_displayfunc()
      let g:leaderGuide#displayname =
          \ substitute(g:leaderGuide#displayname, '\c<CR>$', '', '')
      let g:leaderGuide#displayname =
          \ substitute(g:leaderGuide#displayname, '^<Plug>', '', '')
      let g:leaderGuide#displayname =
          \ substitute(g:leaderGuide#displayname, '^<SID>', '', '')
    endfunction

    let g:leaderGuide_displayfunc = [function("s:my_displayfunc")]
    " }}}

    " mappings {{{
    " leaderGuide database
    let g:leaderDict = {}
    let g:leaderDict[' '] = g:lmap
    let g:leaderDict[' ']['name'] = '<Leader>'
    "let g:leaderDict[','] = g:llmap
    "let g:leaderDict[',']['name'] = '<LocalLeader>'
    call leaderGuide#register_prefix_descriptions("", "g:leaderDict")

    " leaderGuide shortcuts
    nnoremap <silent><nowait> <Leader> :<C-u>LeaderGuide '<Space>'<CR>
    vnoremap <silent><nowait> <Leader> :<C-u>LeaderGuideVisual '<Space>'<CR>
    map <Leader>. <Plug>leaderguide-global

    nnoremap <silent><nowait> <LocalLeader> :<C-u>LeaderGuide  ','<CR>
    vnoremap <silent><nowait> <LocalLeader> :<C-u>LeaderGuideVisual  ','<CR>
    map <LocalLeader>. <Plug>leaderguide-buffer


    " }}}

    " }}}
    " }}}

" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0

