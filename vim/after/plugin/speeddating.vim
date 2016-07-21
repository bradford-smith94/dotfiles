" Bradford Smith
" 07/21/2016
" ~/.vim/after/plugin/speeddating.vim
" vim-speeddating configuration

"define custom date formats for vim-speeddating
"mm/dd/yyyy or mm-dd-yyyy
SpeedDatingFormat %m%[/-]%d%1%Y

"remove roman numeral formats to avoid issues with letters
"see github.com/tpope/vim-speeddating/issues/19
SpeedDatingFormat! %v
SpeedDatingFormat! %V
