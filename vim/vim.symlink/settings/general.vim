" ----------------------------------------------------------------------------
" General Settings
" ----------------------------------------------------------------------------

set nocompatible                " Don't sacrifice anything for Vi compatibility

set history=1000                " Keep some stuff in the history
set ffs=unix,dos,mac            " Support these files
set isk+=_,$,@,%,#,-            " None word dividers
set viminfo='1000,f1,:100,@100,/20
set modeline                    " Make sure modeline support is enabled
set autoread                    " Reload the files if they changed on disk
set tabpagemax=50               " Open 50 tabs max
set encoding=utf-8              " Always use UTF-8 by default
set timeoutlen=500              " Timeout between key command combos

let mapleader=","               " Lead with ,
let g:mapleader=","             " ...and again
let maplocalleader="\\"         " For certain plugins that use localleader

" Pathogen
source ~/.vim/bundle/pathogen/autoload/pathogen.vim
call pathogen#runtime_append_all_bundles()

set nobackup                    " do not keep backups after close
set nowritebackup               " do not keep a backup while working
set noswapfile                  " don't keep swp files either

