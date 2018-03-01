" Bradford Smith
" ~/.vim/ftplugin/vim.vim
" 02/28/2018
" VIM filetype specific configuration

"settings
setlocal foldmethod=marker
setlocal keywordprg=:help

"mappings

"F5 calls my Reload function
nnoremap <buffer> <F5> :update<CR>:execute ":silent! Reload"<CR>
inoremap <buffer> <F5> <C-o>:update<CR><C-o>:execute ":silent! Reload"<CR>
