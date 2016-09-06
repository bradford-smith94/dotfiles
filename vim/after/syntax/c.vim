" Bradford Smith
" ~/.vim/after/syntax/c.vim
" 09/06/2016
" C syntax additions to be loaded after system syntax

"'remove' operator highlighting
hi link Operator Normal

"add preprocessor folding
syntax region preProcFold start="\#if" end="\#endif" transparent fold
