" Bradford Smith
" ~/.vim/autoload/spelling.vim
" updated: 11/16/2017

"function to build the spellfile if it needs to be updated
function! spelling#BuildSpellfileIfNeeded() abort
    "if the file doesn't exist
    if !filereadable(&spellfile . '.spl')
        execute 'silent! mkspell ' . &spellfile
        return
    endif

    "or if the '.add' file was updated more recently
    let l:add_mtime = strftime('%s', getftime(&spellfile))
    let l:spl_mtime = strftime('%s', getftime(&spellfile . '.spl'))
    if l:spl_mtime < l:add_mtime
        execute 'silent! mkspell! ' . &spellfile
    endif
endfunction
