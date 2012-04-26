" nerdtree          git://github.com/scrooloose/nerdtree.git

nmap <Space>d :NERDTreeToggle<CR>
nmap <Leader>d :NERDTreeToggle<CR>
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 0
let g:NERDTreeWinSize = 30
let NERDTreeIgnore=['\.rbc$', '\~$']

" Project Tree
if has("autocmd")
    au VimEnter * silent! call s:CdIfDirectory(expand("<amatch>"))
    au FocusGained * silent! call s:UpdateNERDTree()
    au WinEnter * silent! call s:CloseIfOnlyNerdTreeLeft()
endif

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
    if exists("t:NERDTreeBufName")
        if bufwinnr(t:NERDTreeBufName) != -1
            if winnr("$") == 1
                q
            endif
        endif
    endif
endfunction

" If the parameter is a directory, cd into it
function! s:CdIfDirectory(directory)
    let explicitDirectory = isdirectory(a:directory)
    let directory = explicitDirectory || empty(a:directory)
    if explicitDirectory
        exe "cd " . fnameescape(a:directory)
    endif
    " Allows reading from stdin
    " ex: git diff | mvim -R -
    if strlen(a:directory) == 0
        return
    endif
    if directory
        NERDTree
        wincmd p
        bd
    endif
    if explicitDirectory
        wincmd p
    endif
endfunction

" NERDTree utility functions
function! s:UpdateNERDTree(...)
    let stay = 0
    if(exists("a:1"))
        let stay = a:1
    end
    if exists("t:NERDTreeBufName")
        let nr = bufwinnr(t:NERDTreeBufName)
        if nr != -1
            exe nr . "wincmd w"
            exe substitute(mapcheck("R"), "<CR>", "", "")
            if !stay
                wincmd p
            end
        endif
    endif
    if exists(":CommandTFlush") == 2
        CommandTFlush
    endif
endfunction

function! s:CommandCabbr(abbreviation, expansion)
    execute 'cabbrev ' . a:abbreviation . ' <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "' . a:expansion . '" : "' . a:abbreviation . '"<CR>'
endfunction

function! s:FileCommand(name, ...)
    if exists("a:1")
        let funcname = a:1
    else
        let funcname = a:name
    endif
    execute 'command -nargs=1 -complete=file ' . a:name . ' :silent! call ' . funcname . '(<f-args>)'
endfunction

function! s:DefineCommand(name, destination)
    silent! call s:FileCommand(a:destination)
    silent! call s:CommandCabbr(a:name, a:destination)
endfunction

" Public NERDTree-aware versions of builtin functions
function! ChangeDirectory(dir, ...)
    execute "cd " . fnameescape(a:dir)
    let stay = exists("a:1") ? a:1 : 1
    NERDTree
    if !stay
        wincmd p
    endif
endfunction

function! Touch(file)
    execute "!touch " . shellescape(a:file, 1)
    silent! call s:UpdateNERDTree()
endfunction

function! Remove(file)
    let current_path = expand("%")
    let removed_path = fnamemodify(a:file, ":p")
    if (current_path == removed_path) && (getbufvar("%", "&modified"))
        echo "You are trying to remove the file you are editing. Please close the buffer first."
    else
        execute "!rm " . shellescape(a:file, 1)
    endif
    silent! call s:UpdateNERDTree()
endfunction

function! Mkdir(file)
    execute "!mkdir " . shellescape(a:file, 1)
    silent! call s:UpdateNERDTree()
endfunction

function! Edit(file)
    if exists("b:NERDTreeRoot")
        wincmd p
    endif
    execute "e " . fnameescape(a:file)
    ruby << RUBY
    destination = File.expand_path(VIM.evaluate(%{system("dirname " . shellescape(a:file, 1))}))
    pwd         = File.expand_path(Dir.pwd)
    home        = pwd == File.expand_path("~")
    if home || Regexp.new("^" + Regexp.escape(pwd)) !~ destination
        VIM.command(%{call ChangeDirectory(fnamemodify(a:file, ":h"), 0)})
    end
RUBY
endfunction

" Define the NERDTree-aware aliases
silent! call s:DefineCommand("cd", "ChangeDirectory")
silent! call s:DefineCommand("touch", "Touch")
silent! call s:DefineCommand("rm", "Remove")
silent! call s:DefineCommand("e", "Edit")
silent! call s:DefineCommand("mkdir", "Mkdir")
