" Bradford Smith
" ~/.vim/ftdetect/xdefaults.vim
" updated: 09/22/2017
" xdefaults filetype detection

autocmd BufNewFile,BufRead *.xdefaults set filetype=xdefaults

" rofi config file uses xdefaults syntax
autocmd BufNewFile,BufRead *config/rofi/config set filetype=xdefaults
