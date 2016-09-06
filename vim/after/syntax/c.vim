" Bradford Smith
" 09/06/2016
" ~/.vim/after/syntax/c.vim
" C syntax additions to be loaded after system syntax

"'remove' operator highlighting
hi link Operator Normal

"add preprocessor folding
syntax region preProcFold start="\#if" end="\#endif" transparent fold
