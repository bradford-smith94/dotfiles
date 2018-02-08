" Bradford Smith
" ~/.vim/after/plugin/speeddating.vim
" 02/07/2018
" vim-speeddating configuration

if exists('g:loaded_speeddating')
    "define custom date formats for vim-speeddating
    "mm/dd/yyyy or mm-dd-yyyy
    SpeedDatingFormat %m%[/-]%d%1%Y

    "remove roman numeral formats to avoid issues with letters
    "see github.com/tpope/vim-speeddating/issues/19
    SpeedDatingFormat! %v
    SpeedDatingFormat! %V
endif
