" ~/.vim/ftdetect/dosini.vim
" dosini filetype detection

" polybar config uses dosini syntax
au BufNewFile,BufRead *config/polybar/config set filetype=dosini
" redshift config follows roughly dosini syntax
au BufNewFile,BufRead *config/redshift.conf set filetype=dosini
