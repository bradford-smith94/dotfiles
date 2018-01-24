" Bradford Smith
" ~/.vim/autoload/manpage.vim
" 01/24/2018
" Manpage helper functions

" Format the current buffer as a manpage if it isn't already
function! manpage#Prettify()
    if &filetype !=# 'man'
        silent execute '%! col -b'
        setlocal filetype=man
    endif
endfunction

" Helper function for saving manpage as a tmpfile
function! manpage#SaveStdinManpage()
    let s:tmp_dir = system("mktemp -d 2>/dev/null || mktemp -d -t 'vim-tmp'")
    execute 'chdir ' . s:tmp_dir
    silent execute '%! col -b'
    file $MAN_PN
    write
    setlocal filetype=man
    augroup tmp_manpage_delete
        autocmd!
        autocmd VimLeavePre * execute '!rm -r ' . s:tmp_dir
    augroup END
endfunction
