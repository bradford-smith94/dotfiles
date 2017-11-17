" Bradford Smith
" ~/.vim/autoload/syntax.vim
" updated: 11/16/2017

"function to show the highlight group of the word under the cursor
"see: http://vim.wikia.com/wiki/Showing_syntax_highlight_group_in_statusline
function! syntax#ShowHighlightGroup() abort
    echo synIDattr(synID(line('.'),col('.'),1),'name')
endfunction

"function to show the effective highlight group (follows links) of the word
"under the cursor, a basic trace of what groups are in use
"see: http://vim.wikia.com/wiki/VimTip99
function! syntax#ShowHighlightLink() abort
    let l:item = synIDattr(synID(line('.'),col('.'),1),'name')
    let l:transparent_item = synIDattr(synID(line('.'),col('.'),0),'name')
    let l:link = synIDattr(synIDtrans(synID(line('.'),col('.'),1)),'name')

    if l:item !=# l:transparent_item
        echo 'hi<' . l:item . '> transparent<' . l:transparent_item . '>'
                    \ . 'links to<' . l:link . '>'
    else
        echo 'hi<' . l:item . '> links to<' . l:link . '>'
    endif
endfunction
