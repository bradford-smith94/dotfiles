" Bradford Smith
" ~/.vim/ftplugin/vim.vim
" 2018-06-13
" VIM filetype specific configuration

"settings
setlocal foldmethod=marker
setlocal keywordprg=:help

let g:syntastic_vim_checkers = ['vint']

"mappings

"F5 calls my Reload function
nnoremap <buffer> <F5> :update<CR>:execute ":silent! Reload"<CR>
inoremap <buffer> <F5> <C-o>:update<CR><C-o>:execute ":silent! Reload"<CR>
