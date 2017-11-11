" Bradford Smith
" ~/.vim/ftplugin/vim.vim
" 11/11/2017
" VIM filetype specific configuration

"settings
setlocal foldmethod=marker
setlocal keywordprg=:help

"mappings

"F5 calls my Reload function
nnoremap <buffer> <F5> :w<CR>:execute ":silent! Reload"<CR>
inoremap <buffer> <F5> <C-o>:w<CR><C-o>:execute ":silent! Reload"<CR>
