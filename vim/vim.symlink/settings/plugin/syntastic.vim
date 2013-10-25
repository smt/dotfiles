" syntastic         git://github.com/scrooloose/syntastic.git
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': ['php', 'javascript'],
                           \ 'passive_filetypes': ['less', 'sass', 'scss', 'css', 'html', 'ruby'] }

"mark syntax errors with :signs
let g:syntastic_enable_signs=1

"automatically jump to the error when saving the file
let g:syntastic_auto_jump=0

"show the error list automatically
let g:syntastic_auto_loc_list=1

"don't care about warnings
let g:syntastic_quiet_warnings=0

