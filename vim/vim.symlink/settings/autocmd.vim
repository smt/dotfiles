" ----------------------------------------------------------------------------
" Autocommands
" ----------------------------------------------------------------------------

filetype on
filetype plugin on
filetype indent on
filetype plugin indent on

if has("autocmd")
    " Remember last location in a file
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

    " Save on lose focus
    au FocusLost * :wa

    " Source .vimrc on save
    au BufWritePost .vimrc source $MYVIMRC

    " Keep splits sized properly
    au VimResized * exe "normal! \<cw>="

    " Syntax of these languages is fussy over tabs vs spaces
    au FileType make       setlocal ts=4 sts=4 sw=4 noet
    au FileType yaml,haml  setlocal ts=2 sts=2 sw=2 et

    " Whitespace based on house-style (arbitrary)
    au FileType html       setlocal ts=4 sts=4 sw=4 noet
    au FileType xhtml      setlocal ts=4 sts=4 sw=4 et
    au FileType css        setlocal ts=4 sts=4 sw=4 noet
    au FileType ruby       setlocal ts=2 sts=2 sw=2 et
    au FileType sass       setlocal ts=2 sts=2 sw=2 et
    au FileType less       setlocal ts=4 sts=4 sw=4 noet
    au FileType javascript setlocal ts=4 sts=4 sw=4 noet
    au FileType xml        setlocal ts=4 sts=4 sw=4 et

    "" HTML
    au FileType html,xhtml setlocal fo+=tl                      " for HTML, generally format text, but if a long line has been created leave it alone when editing:
    au BufNewFile,BufRead *.{jsp,jspf} setlocal ft=jsp.html     " set .jsp files to edit like HTML

    "" CSS
    au BufNewFile,BufRead *.scss setlocal ft=scss.css           " Get CSS snippets in SCSS files
    au BufNewFile,BufRead *.less setlocal ft=less.css           " Get CSS snippets in LESS files

    "" JavaScript
    au BufNewFile,BufRead *.{json,htc} setlocal ft=javascript   " Syntax highlighting for JSON files

    "" Python
    highlight OverLength ctermbg=red ctermfg=white guibg=#592929
    au FileType python setlocal ts=4 sts=4 sw=4 et              " make python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
    au FileType python match OverLength /\%79v.\+/

    "" PHP
    au BufNewFile,BufRead *.ctp setlocal ft=php                 " set .ctp files to edit like php for cakePHP

    "" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
    au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} setlocal ft=ruby

    "" Markdown -- markdown, md, mk, mkd, pdk, pandoc, and text are markdown and define buffer-local preview
    au FileType markdown,md,mk,mkd,pdk,pandoc,text nnoremap <buffer> <localleader>1 yypVr=
    au FileType markdown,md,mk,mkd,pdk,pandoc,text nnoremap <buffer> <localleader>2 yypVr-

    "" reStructuredText
    au FileType rst nnoremap <buffer> <localleader>1 yypVr=
    au FileType rst nnoremap <buffer> <localleader>2 yypVr-
    au FileType rst nnoremap <buffer> <localleader>3 yypVr~
    au FileType rst nnoremap <buffer> <localleader>4 yypVr`

    "" Open help files in a vertical split
    au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
endif


