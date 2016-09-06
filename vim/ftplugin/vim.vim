" Bradford Smith
" ~/.vim/ftplugin/vim.vim
" 09/06/2016
" VIM filetype specific configuration

"settings
setlocal foldmethod=marker

"mappings

"F5 calls my Reload function
noremap <buffer> <F5> :w<CR>:execute ":silent! Reload"<CR>
inoremap <buffer> <F5> <C-o>:w<CR><C-o>:execute ":silent! Reload"<CR>

"K searches help for word under cursor
nnoremap <buffer> K :execute ":help " . expand("<cword>")<CR>
