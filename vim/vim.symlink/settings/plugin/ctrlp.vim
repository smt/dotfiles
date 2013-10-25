" ctrlp             git://github.com/kien/ctrlp.vim.git

map <D-t> :CtrlP<CR>
imap <D-t> <Esc>:CtrlP<CR>
nmap <Leader>f :ClearCtrlPCache<CR>
let g:ctrlp_working_path_mode = 0

" We don't want to use Ctrl-p as the mapping because
" it interferes with YankRing (paste, then hit ctrl-p)
let g:ctrlp_map = '<Leader>t'

" Additional mapping for buffer search
nnoremap <Leader>b :CtrlPBuffer<cr>
nnoremap <C-b> :CtrlPBuffer<cr>

" Idea from : http://www.charlietanksley.net/blog/blog/2011/10/18/vim-navigation-with-lustyexplorer-and-lustyjuggler/
" Open CtrlP starting from a particular path, making it much
" more likely to find the correct thing first. mnemonic 'jump to [something]'
" map <Leader>jm :CtrlP app/models<CR>
" map <Leader>jc :CtrlP app/controllers<CR>
" map <Leader>jv :CtrlP app/views<CR>
" map <Leader>jh :CtrlP app/helpers<CR>
" map <Leader>jl :CtrlP lib<CR>
" map <Leader>jp :CtrlP public<CR>
" map <Leader>js :CtrlP spec<CR>
" map <Leader>jf :CtrlP fast_spec<CR>
" map <Leader>jt :CtrlP test<CR>
" map <Leader>jd :CtrlP db<CR>
" map <Leader>jC :CtrlP config<CR>
" map <Leader>jV :CtrlP vendor<CR>
" map <Leader>jF :CtrlP factories<CR>

