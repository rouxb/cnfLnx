""" Nvim core mappings structure
" Define main shortcut for global command,
" navigation in windows, tabs, file mgmt ...
" Define main navigation and file mgmt shortcuts.

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
    let s:focusStatus = {}

    " functions {{{
    function! mappings#FocusFile()
      let a:curTab = tabpagenr()
      if a:curTab ># (tabpagenr('$') - len(s:focusStatus)) " Unfocus
       for [key, val] in items(s:focusStatus) " parse dict to find origin tab
         if (a:curTab ==# val)
           let a:origTab = key
           :break
         endif
       endfor
       "tab clear dict, jump to origin and remove focused 
       call remove(s:focusStatus, a:origTab)
       execute 'tabnext ' . a:origTab
       execute "tabclose " . a:curTab
      else
      " check focus status
        if has_key(s:focusStatus, tabpagenr()) "should never append
          echo "Strange behavior, check focusStatus management"
        endif
        " Save current tab and trgtFile
        let a:trgtFile = @%
        let a:curTab = tabpagenr()
        "move to last tab create focus and open file
        execute 'tabnext ' . tabpagenr('$')
        execute "tabnew focus" . a:curTab
        execute "edit " . a:trgtFile

        "register focus in focusStatus
        let s:focusStatus[a:curTab] = tabpagenr()
      endif
    endfunction
    " }}}

    " mappings {{{
      " native remap
      nnoremap <Plug>(window_h) <C-W>h
      nnoremap <Plug>(window_l) <C-W>l
      nnoremap <Plug>(window_j) <C-W>j
      nnoremap <Plug>(window_k) <C-W>k
      nnoremap <Plug>(window_w) <C-W>w

      nnoremap <Plug>(window_H) <C-W>H
      nnoremap <Plug>(window_L) <C-W>L
      nnoremap <Plug>(window_J) <C-W>J
      nnoremap <Plug>(window_K) <C-W>K
      nnoremap <Plug>(window_R) <C-W>R

      nnoremap <Plug>(window_b) <C-W>=
      nnoremap <Plug>(window_rh) <C-W>5>
      nnoremap <Plug>(window_rl) <C-W>5<
      nnoremap <Plug>(window_rj) :resize +5<CR>
      nnoremap <Plug>(window_rk) :resize -5<CR>

    " leaderGuide map
    let g:lmap.w = { 'name' : '+windows' }
      " split
      let g:lmap.w.s = ['split', 'split-window-above']
      let g:lmap.w.v = ['vsplit', 'split-window-right']
      " move selection
      let g:lmap.w.h = ['call feedkeys("\<Plug>(window_h)")', 'select-left-window']
      let g:lmap.w.l = ['call feedkeys("\<Plug>(window_l)")', 'select-right-window']
      let g:lmap.w.j = ['call feedkeys("\<Plug>(window_j)")', 'select-down-window']
      let g:lmap.w.k = ['call feedkeys("\<Plug>(window_k)")', 'select-up-window']
      let g:lmap.w.r = ['call feedkeys("\<Plug>(window_w)")', 'select-rotate']
    " move windows
      let g:lmap.w.H = ['call feedkeys("\<Plug>(window_H)")', 'move-window-left']
      let g:lmap.w.L = ['call feedkeys("\<Plug>(window_L)")', 'move-window-right']
      let g:lmap.w.J = ['call feedkeys("\<Plug>(window_J)")', 'move-window-down']
      let g:lmap.w.K = ['call feedkeys("\<Plug>(window_K)")', 'move-window-up']
      let g:lmap.w.R = ['call feedkeys("\<Plug>(window_R)")', 'move-rotate']
    " resize windows
    let g:lmap.w['='] = ['call feedkeys("\<Plug>(window_b)")', 'balance-window']
    let g:lmap.w.r = { 
        \'name' : '+resize',
        \ '=' : ['call feedkeys("\<Plug>(window_b)")', 'balance-window'],
        \ 'h' : ['call feedkeys("\<Plug>(window_rh)")', 'expand-left'],
        \ 'l' : ['call feedkeys("\<Plug>(window_rl)")', 'expand-right'],
        \ 'j' : ['call feedkeys("\<Plug>(window_rj)")', 'expand-below'],
        \ 'k' : ['call feedkeys("\<Plug>(window_rk)")', 'expand-above']}
    " focus on current file
      let g:lmap.w.m = ['call mappings#FocusFile()', 'focus-file']
    " }}}

    " }}}

    " layout management {{{
    let s:prevTab = 1

    " functions {{{
   function! mappings#ChTab(trgtTab)
     " Move tab cyclic with history
     let a:ppTab = s:prevTab
     let s:prevTab = tabpagenr()

    " check init focus status, parse dict to find origin tab in case of focus
    let a:curTab = tabpagenr()
    if has_key(s:focusStatus, a:curTab)
      let a:curTab = s:focusStatus[a:curTab]
    else
       for [key, val] in items(s:focusStatus)
         if (a:curTab ==# val)
           let a:curTab = key
           :break
         endif
      endfor
    endif

     echo "trgtTab: " . a:trgtTab
     echo "curTab: " . a:curTab

     " find nextTab
     let a:nextTab = a:curTab
     if a:trgtTab ==# "+"
       let a:nextTab = (a:curTab + 1)
       let a:nextTab = ((a:nextTab ==# ((tabpagenr('$')+1) - len(s:focusStatus)))? 1: a:nextTab)
     elseif a:trgtTab ==# "-"
       let a:nextTab = (a:curTab - 1)
       let a:nextTab = ((a:nextTab ==# 0)? (tabpagenr('$') - len(s:focusStatus)): a:nextTab)
     elseif a:trgtTab ==# "t" "Toggle tab
       let a:nextTab = a:ppTab
     else 
       let a:nextTab = a:trgtTab
     endif

     echo "nextTab: " . a:nextTab
    " check trgt focus status
    if has_key(s:focusStatus, a:nextTab)
      let a:nextTab = s:focusStatus[a:nextTab]
      execute 'tabnext ' . a:nextTab
    elseif a:nextTab ># (tabpagenr('$') - len(s:focusStatus))
       call mappings#Tab_new(a:curTab)
     else
       execute 'tabnext ' . a:nextTab
     endif
   endfunction

   function! mappings#Tab_new(fromTab)
     " Create new tab with history
     let s:prevTab = a:fromTab
     "ask for name
     call inputsave()
     let a:tabName = input('New layer name: ')
     call inputrestore()
     "create it before focused tab
     if (len(s:focusStatus) ># 0) "slide all focus pan to the right
       for [key, val] in items(s:focusStatus)
         let s:focusStatus[key] = (val + 1)
       endfor
     endif
     " move before targeted position and create tab
     execute 'tabnext ' . (tabpagenr('$') - len(s:focusStatus))
     execute '$tabnew ' . a:tabName
   endfunction

   function! mappings#Tab_close()
     " close tab and go to previous
     " rearrange focused tab index
     let a:tabToClose = tabpagenr()
     let a:newFocus = {}
     for [key, val] in items(s:focusStatus)
       if (key ># a:tabToClose) " Change base tab and trgt
         let a:newFocus[key-1] = (val -1)
         call remove(a:tabToClose, key)
       else
        let s:focusStatus[key] = (val ># a:tabToClose)?(val-1):val "change trgt focus
      endif
      " Append newFocus to focusStatus
      call extend(s:focusStatus, a:newFocus)
     endfor

     echo "target tab is " . s:prevTab
     call mappings#ChTab(s:prevTab)
     execute 'tabclose' . a:tabToClose
   endfunction

    function! mappings#MvTab(direction)
      " TODO
    endfunction
    " }}}

    " mappings {{{
    let g:lmap.l = { 'name' : '+layouts'}
    let g:lmap.l.c = ['call mappings#Tab_new('. tabpagenr(). ')', 'create-tab']
    let g:lmap.l.d = ['call mappings#Tab_close()', 'delete-tab']
    let g:lmap.l.n = ['call mappings#ChTab("+")', 'tab-next']
    let g:lmap.l.p = ['call mappings#ChTab("-")', 'tab-prev']
    let g:lmap.l.1 = ['call mappings#ChTab(1)', 'gt-tab1']
    let g:lmap.l.2 = ['call mappings#ChTab(2)', 'gt-tab2']
    let g:lmap.l.3 = ['call mappings#ChTab(3)', 'gt-tab3']
    let g:lmap.l.4 = ['call mappings#ChTab(4)', 'gt-tab4']
    let g:lmap.l.5 = ['call mappings#ChTab(5)', 'gt-tab5']
    let g:lmap.l.6 = ['call mappings#ChTab(6)', 'gt-tab6']
    let g:lmap.l.7 = ['call mappings#ChTab(7)', 'gt-tab7']
    let g:lmap.l.8 = ['call mappings#ChTab(8)', 'gt-tab8']
    let g:lmap.l.9 = ['call mappings#ChTab(9)', 'gt-tab9']
    let g:lmap.l.0 = ['call mappings#ChTab(0)', 'gt-tab10']
    " Use <C-I> to map tab key
    let g:lmap.l['<C-I>'] = ['call mappings#ChTab("t")', 'toggle-tab']
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
    " Display scripts vars for debug purpose {{{
    function! mappings#DebugDisplay()
      echo "focusStatus: "
      echo s:focusStatus
      echo "len(focusStatus): " . len(s:focusStatus)
      echo "prevTab: " . s:prevTab
    endfunction
    " }}}
    " }}}

" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0

