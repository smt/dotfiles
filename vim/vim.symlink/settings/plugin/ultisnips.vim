" declare global configuration dictionary so that config options can be added:
let g:UltiSnips = {}

" customize mappings, eg use snipmate like behaviour
let g:UltiSnips.ExpandTrigger = "<C-\\>"
let g:UltiSnips.JumpForwardTrigger = "<C-j>"
let g:UltiSnips.JumpBackwardTrigger = "<C-k>"

" Now its time to tell UltiSnips about which snippets to load.
" You do so for snipmate snippets and UltiSnips snippets individually.
" This example illustrates a setup loading snipmate snippets.

" See plugin/UltiSnips.vim, it has much additional documentation.
" Assuming you're not overrding default implemenation the default
" VimL function SnippetFilesForCurrentExpansionDefaultImplementation


" == UltiSnips snippets ==
" Because I want to use the snippet snippets 'default' does not load
" filetype.snippets snippet files. 'all' reperesents the snippets like box
" which are meant to be present always. (snipmate was using _ for this)
" For cpp, already all snippets have been converted to UltiSnips, so use
" those - but only the one provided by my ~/.vim direcotry.
let g:UltiSnips.UltiSnips_ft_filter = {
            \ 'default' : {'filetypes': ['all', 'FILETYPE'] },
            \ 'all' : {'filetypes': ['all', 'FILETYPE'] },
            \ 'cpp' : {'filetypes': ['cpp'], 'dir-regex': '[._]vim/UltiSnips$' },
            \ 'javascript' : {'filetypes': ['javascript'], 'dir-regex': '[._]vim/UltiSnips$' },
            \ }
" you may want to replace ['all'] by ['all','FILETYPE'] in order to load
" all snippets - If you load all snipmate-snippets and UltiSnips snippets
" you may also want to set always_use_first_snippet configuration option to
" 1 like this:
let g:UltiSnips.always_use_first_snippet = 1

" == snipmate snippets ==
" For any other filetype do what I used in the past: snipmate-snippets
" repo (must be added to runtimepath)
" _ represents snipmate snippets which are present always
let g:UltiSnips.snipmate_ft_filter = {
            \ 'default' : {'filetypes': ["FILETYPE", "_"] },
            \ 'html'    : {'filetypes': ["html", "javascript", "_"] },
            \ 'xhtml'    : {'filetypes': ["xhtml", "html", "javascript", "_"] },
            \ 'cpp'    : {'filetypes': [] },
            \ }
