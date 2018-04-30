""" Nvim commenter plugin
" Define shortcut wrapper around existing vim plugin

" commenter {{{

  " requiered plugins {{{
    call dein#add('tpope/commentary')
  " }}}

  " leaderGuide map {{{
  " leaderGuide map
    let g:lmap.c = { 'name' : '+comment' }
      " toggle
      let g:lmap.c.l = ['toggle', 'Commentary']

  " }}}
  
" }}}
