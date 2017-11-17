" Bradford Smith
" ~/.vim/autoload/formatting.vim
" updated: 11/16/2017

"see: vim.wikia.com/wiki/Remove_unwanted_spaces
"+: stackoverflow.com/questions/6496778/vim-run-autocmd-on-all-filetypes-except
function! formatting#RemoveTrailingSpaces() abort
    if !&binary && &filetype !=# 'diff'
        if !exists('b:keepTrailingSpaces')
            normal! mz
            normal! Hmy
            "vint: -ProhibitCommandRelyOnUser
            "vint: -ProhibitCommandWithUnintendedSideEffect
            %s/\s\+$//e
            "vint: +ProhibitCommandWithUnintendedSideEffect
            "vint: +ProhibitCommandRelyOnUser
            normal! 'yz<CR>
            normal! `z
        endif
    endif
endfunction
