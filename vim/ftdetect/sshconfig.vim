" Bradford Smith
" ~/.vim/ftdetect/sshconfig.vim
" updated: 2019-11-07
" ssh config filetype detection

autocmd BufNewFile,BufRead */ssh/config,*/.ssh/config.* set filetype=sshconfig
