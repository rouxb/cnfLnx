""" Nvim configuration files
" Configure global parameters
" Then start core components

""" Force configuration update: 
" after restart Neovim (or Vim),
" run `call dein#clear_state() || call dein#update()` to apply changes

" Path configuration {{{
	let g:nvim_path_separator='/'
	let g:nvim_dir= '~' . g:nvim_path_separator . '.cnfLnx' 
				\ . g:nvim_path_separator . 'vim' 
" }}}

" Leader keys {{{
  let mapleader = ' '
  let g:mapleader = ' '
  let maplocaleader = ' '
" }}}

" Global configuration {{{
  let g:cnf_nvim = {}

	" Leader keys
	let g:cnf_nvim.glbLeader=' '
	let g:cnf_nvim.localLeader=','

  " layers configuration
  let g:cnf_nvim.layers = [
      \ 'core',
      \ 'navigation',
      \ 'indents',
      \ 'completion',
      \ 'editing',
      \ 'language',
      \ 'python',
      \ 'c',
      \ 'misc']

  " enabled plugins
  let g:cnf_nvim.enabled_plugins = []

  " disabled plugins
  let g:cnf_nvim.disabled_plugins = []

" }}}

" Core configuration {{{
  let g:cnf_nvim.default_indent = 2
  "let g:cnf_nvim.bin_dir = '/usr/local/bin'
	
  " plugins
  let g:cnf_nvim.cscopeprg = 'gtags-cscope'
  "let g:cnf_nvim.cscopeprg = 'cscope'
  let g:cnf_nvim.completion_autoselect = 1
  let g:cnf_nvim.syntaxcheck_autoselect = 1
  let g:cnf_nvim.explorer_plugin = 'nerdtree'
  "let g:cnf_nvim.explorer_plugin = 'vimfiler'
  let g:cnf_nvim.statusline_plugin = 'airline'
  "let g:cnf_nvim.statusline_plugin = 'lightline'
" }}}

" UI Configuration {{{
  let g:cnf_nvim.colorscheme = 'space-vim-dark'
  "let g:cnf_nvim.colorscheme = 'molokai'
  "let g:cnf_nvim.colorscheme = 'solarized'
  "let g:cnf_nvim.colorscheme = 'jellybeans'
  "let g:cnf_nvim.colorscheme = 'onedark'
  let g:cnf_nvim.force256 = 0
  let g:cnf_nvim.termtrans = 0
  let g:cnf_nvim.max_column = 80
  let g:cnf_nvim.powerline_fonts = 0
  let g:cnf_nvim.nerd_fonts = 0
"}}}

" Custom hook before startup {{{
function! BeforeAll_hook()
  "define global variable for storing layerName
   let g:fixTabNameForLayer = {1: "Sandbox"}
endfunction
"}}}

" Custom hook after startup {{{
function! AfterAll_hook()
  " use spaces instead of tabs
  set expandtab
  "set noexpandtab
endfunction

" DO NOT EDIT """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Call core configuration {{{

" PreConfig Hook {{{
  call BeforeAll_hook()
"}}}

" Core {{{
  execute 'source ' . fnamemodify(resolve(expand('<sfile>')), ':p:h') .
      \ g:nvim_path_separator . 'core' . g:nvim_path_separator . 'main.vim'
"}}}

" endConfig Hook {{{
  call AfterAll_hook()
"}}}
"}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0

