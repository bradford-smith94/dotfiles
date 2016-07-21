" Bradford Smith
" 07/21/2016
" ~/.vim/ftplugin/vim.vim
" VIM filetype specific configuration

"settings
setlocal foldmethod=marker

"mappings
noremap <buffer> <F5> :w<CR>:execute ":silent! Reload"<CR>
inoremap <buffer> <F5> <Esc>:w<CR>:execute ":silent! Reload"<CR>
