" Bradford Smith
" ~/.vim/ftdetect/dosini.vim
" updated: 09/22/2017
" dosini filetype detection

" polybar config uses dosini syntax
autocmd BufNewFile,BufRead *config/polybar/config set filetype=dosini
" redshift config follows roughly dosini syntax
autocmd BufNewFile,BufRead *config/redshift.conf set filetype=dosini
" npmrc config follows ini syntax
autocmd BufNewFile,BufRead npmrc set filetype=dosini
