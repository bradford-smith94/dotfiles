" Bradford Smith
" ~/.vim/ftplugin/html.vim
" 2018-04-30
" HTML filetype specific configuration

"settings
setlocal wrap
setlocal foldmethod=indent
setlocal omnifunc=htmlcomplete#CompleteTags

"mappings
if executable('google-chrome-stable') == 1
    nnoremap <buffer> <F5> :update<CR>:execute "!google-chrome-stable " . bufname("%")<CR>
    inoremap <buffer> <F5> <C-o>:update<CR><C-o>:execute "!google-chrome-stable " . bufname("%")<CR>
endif

inoremap </ </<C-x><C-o>

"source typo autocorrection
source ~/.vim/custom/typo_autocorrect.vim
