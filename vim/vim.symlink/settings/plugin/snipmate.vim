" snipmate          git://github.com/garbas/vim-snipmate.git
let g:snips_author = "Stephen Tudor"
" let g:snips_trigger_key = '<C-Space>'

if !exists('g:snipMate')
  let g:snipMate = {}
  let g:snipMate.scope_aliases = {}
endif
let g:snipMate.scope_aliases['dust'] = 'html'
let g:snipMate.scope_aliases['javascript'] = 'javascript,javascript-jquery'
let g:snipMate.scope_aliases['jsp'] = 'jsp,html'
let g:snipMate.scope_aliases['less'] = 'less,css'
let g:snipMate.scope_aliases['scss'] = 'scss,css'
