" ~/.vim/ftdetect/xdefaults.vim
" xdefaults filetype detection
au BufNewFile,BufRead *.xdefaults set filetype=xdefaults

" rofi config file uses xdefaults syntax
au BufNewFile,BufRead *config/rofi/config set filetype=xdefaults
