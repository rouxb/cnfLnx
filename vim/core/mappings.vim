""" Nvim core mappings structure
" Define main shortcut for global command,
" navigation in windows, tabs, file mgmt ...
" Define main navigation and file mgmt shortcuts.

function! Create_tab()
  call inputsave()
  let $name = input('Enter name: ')
  call inputrestore()
  execute 'tabnew' . " " . $name
endfunction
" mappings {{{
  " map container
  let g:lmap = {}
  let g:mlmap = {}

  " requiered plugins {{{
    call dein#add('taohex/vim-leader-guide')
    call dein#add('Shougo/denite.nvim')
    call dein#add('Shougo/neomru.nvim')
    call dein#add('scrooloose/nerdtree')
  " }}}

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

    " layout management {{{
    let s:prevTab = 0
    let s:curTab = 0
    let s:idxTab = 0

    " functions {{{
    function! mappings#ChTab(direction)
      let s:prevTab = s:curTab " manage index
      if s:curTab + a:direction < 0
          let s:curTab = s:idxTab
      elseif s:curTab + a:direction > s:idxTab
          let s:curTab = s:idxTab
      else 
        let s:curTab = s:curTab + a:direction
      endif

      if a:direction == -1 " mv tab
        :-tabnext
      else
        :+tabnext
      endif
    endfunction

    function! mappings#Goto_tab(trgtTab)
      if a:trgtTab > s:idxTab " if no trgt tab, create it
        call mappings#Tab_new()
      else
        let a:trgt = a:trgtTab + 1
        execute 'tabnext ' . a:trgt
        " update tab index and history
        let s:prevTab = s:curTab
        let s:curTab = a:trgtTab
      endif
    endfunction

    function! mappings#Tab_new()
      "ask for name
      call inputsave()
      let tabName = input('New layer name: ')
      call inputrestore()
      "create it
      execute '$tabnew ' . tabName
      " update tab index and history
      let s:prevTab = s:curTab
      let s:idxTab = s:idxTab +1
      let s:curTab = s:idxTab
    endfunction

    function! mappings#Tab_close()
      " close tab and go to previous
      execute 'tabclose'
      mappings#Goto_tab(s:prevTab)

      " update tab index and history
      let s:curTab = s:prevTab
      let s:idxTab = s:idxTab - 1
    endfunction

    function! mappings#MvTab(direction)
      " check border
      if (( s:curTab + a:direction) < 0
        ||  ( s:curTab + a:direction) > s:idxTab)
        " do nothing
      else
      " swap prev with cur if needed
        if s:prevtab = s:curTab + a:direction
          let a:tmp = s:curTab
          let s:curTab = s:prevTab
          let s:prevTab = a:tmp
        endif
        if a:direction > 0
          execute 'tabmove -1'
        else
          execute 'tabmove +1'
        endif
    endfunction
    " }}}

    " mappings {{{
    let g:lmap.l = { 'name' : '+layouts'}
    let g:lmap.l.c = ['call mappings#Tab_new()', 'create-tab']
    let g:lmap.l.d = ['call mappings#Tab_close()', 'delete-tab']
    let g:lmap.l.n = ['call mappings#ChTab(1)', 'tab-next']
    let g:lmap.l.p = ['call mappings#ChTab(-1)', 'tab-prev']
    let g:lmap.l.0 = ['call mappings#Goto_tab(0)', 'gt-tab0']
    let g:lmap.l.1 = ['call mappings#Goto_tab(1)', 'gt-tab1']
    let g:lmap.l.2 = ['call mappings#Goto_tab(2)', 'gt-tab2']
    let g:lmap.l.3 = ['call mappings#Goto_tab(3)', 'gt-tab3']
    let g:lmap.l.4 = ['call mappings#Goto_tab(4)', 'gt-tab4']
    let g:lmap.l.5 = ['call mappings#Goto_tab(5)', 'gt-tab5']
    let g:lmap.l.6 = ['call mappings#Goto_tab(6)', 'gt-tab6']
    let g:lmap.l.7 = ['call mappings#Goto_tab(7)', 'gt-tab7']
    let g:lmap.l.8 = ['call mappings#Goto_tab(8)', 'gt-tab8']
    let g:lmap.l.9 = ['call mappings#Goto_tab(9)', 'gt-tab9']
    " Use <C-I> to map tab key
    let g:lmap.l['<C-I>'] = ['call mappings#Goto_tab(' . s:prevTab . ')', 'toggle-tab']
    " subcat for mvt
    let g:lmap.l.m = {'name': '+tab-move'}
    let g:lmap.l.m.p = ['call mappings#MvTab(-1)', 'mv-prev']
    let g:lmap.l.m.n = ['call mappings#MvTab(1)', 'mv-next']
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
    let g:lmap.b.d = ['bw', 'delete-buffer']
    " denite buffer search
    let g:lmap.b.b = ['Denite -auto-resize -buffer-name=buffers buffer file_mru', 'denite-buffer']
    " }}}
    " }}}

    " file management {{{
    " functions {{{
    " }}}

    " mappings {{{
    let g:lmap.f = { 'name' : '+files' }
    let g:lmap.f.f = ['Denite -auto-resize -buffer-name=files file_rec', 'denite-file']
    let g:lmap.f.m = ['Denite -auto-resize -buffer-name=mixed buffer file_rec file_mru bookmark', 'denite-mixed']
    let g:lmap.f.r = ['Denite -auto-resize -buffer-name=recent file_mru', 'denite-mru']
    let g:lmap.f.s = ['DeniteCursorWord -no-quit -auto-resize -buffer-name=search grep:.', 'denite-search']
    let g:lmap.f.t = ['NERDTreeToggle', 'NerdTree']
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

