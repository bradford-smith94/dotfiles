" Bradford Smith
" ~/.vim/autoload/mappings.vim
" updated: 11/16/2017

"function to unmap and restore any enter key mappings (<CR>) when
"   entering/leaving the cmdwin, arg 'enter' specifies whether or not the
"   function has been called when entering the cmdwin
function! mappings#CmdWinEnterMapping(enter) abort
    if a:enter == 1
        let b:prev_cr_map = maparg('<CR>', 'n')

        "if there was no previous mapping don't set the variable
        if b:prev_cr_map ==# ''
            unlet b:prev_cr_map
        else
            nunmap <CR>
        endif
    else
        if exists('b:prev_cr_map')
            execute 'nnoremap <CR> ' . b:prev_cr_map
            unlet b:prev_cr_map
        endif
    endif
endfunction
