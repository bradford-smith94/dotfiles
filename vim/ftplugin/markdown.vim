"settings
setlocal wrap
setlocal spell
setlocal formatoptions-=tc
setlocal omnifunc=htmlcomplete#CompleteTags

" Auto lists: Automatically continue/end lists by adding markers if the
" previous line is a list item, or removing them when they are empty

" credit: https://gist.github.com/sedm0784/dffda43bcfb4728f8e90
function! s:auto_list()
    let l:preceding_line = getline(line(".") - 1)
    if l:preceding_line =~ '\v^\d+\.\s.'
        " The previous line matches any number of digits followed by a full-stop
        " followed by one character of whitespace followed by one more character
        " i.e. it is an ordered list item

        " Continue the list
        let l:list_index = matchstr(l:preceding_line, '\v^\d*')
        call setline(".", l:list_index + 1. ". ")
    elseif l:preceding_line =~ '\v^\d+\.\s$'
        " The previous line matches any number of digits followed by a full-stop
        " followed by one character of whitespace followed by nothing
        " i.e. it is an empty ordered list item

        " End the list and clear the empty item
        call setline(line(".") - 1, "")
    elseif l:preceding_line[0] == "-" && l:preceding_line[1] == " "
        " The previous line is an unordered list item
        if strlen(l:preceding_line) == 2
            " ...which is empty: end the list and clear the empty item
            call setline(line(".") - 1, "")
        else
            " ...which is not empty: continue the list
            call setline(".", "- ")
        endif
    endif
endfunction

" enable for <Enter> in Insert and o in Normal
inoremap <buffer> <CR> <CR><Esc>:call <SID>auto_list()<CR>A
nnoremap <buffer> o o<Esc>:call <SID>auto_list()<CR>A
