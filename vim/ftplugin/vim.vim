" Bradford Smith
" 07/28/2016
" ~/.vim/ftplugin/vim.vim
" VIM filetype specific configuration

"settings
setlocal foldmethod=marker

"mappings

"F5 calls my Reload function
noremap <buffer> <F5> :w<CR>:execute ":silent! Reload"<CR>
inoremap <buffer> <F5> <Esc>:w<CR>:execute ":silent! Reload"<CR>

"K searches help for word under cursor
nnoremap <buffer> K :execute ":help " . expand("<cword")<CR>
