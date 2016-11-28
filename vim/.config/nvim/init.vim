let $NVIM_TUI_ENABLE_TRUE_COLOR = 1

let g:python_host_prog = '/usr/bin/python2'

execute 'source' fnamemodify(expand('<sfile>'), ':h').'/../.vimrc'
