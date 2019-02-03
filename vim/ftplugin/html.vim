" Bradford Smith
" ~/.vim/ftplugin/html.vim
" 2019-02-03
" HTML filetype specific configuration

"settings
setlocal wrap
setlocal foldmethod=indent
setlocal omnifunc=htmlcomplete#CompleteTags

let g:syntastic_html_checkers = ['validator']

"mappings
if executable('google-chrome-stable') == 1
    nnoremap <buffer> <F5> :update<CR>:execute "!xdg-open " . bufname("%")<CR>
    inoremap <buffer> <F5> <C-o>:update<CR><C-o>:execute "!xdg-open " . bufname("%")<CR>
endif

inoremap </ </<C-x><C-o>

"source typo autocorrection
source ~/.vim/custom/typo_autocorrect.vim
