" solarized         git://github.com/altercation/vim-colors-solarized.git
let g:solarized_termtrans = 1
let g:solarized_visibility = "low"
let g:solarized_menu = 0
"let g:solarized_termcolors = 16
let g:solarized_hitrail = 1
call togglebg#map('<F5>')

if has('gui_running')
    set background=light
else
    let g:solarized_termcolors=256
    set background=dark
endif
