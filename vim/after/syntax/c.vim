" Bradford Smith
" 07/21/2016
" ~/.vim/after/syntax/c.vim
" C syntax additions to be loaded after system syntax

"add preprocessor folding
syntax region preProcFold start="\#if" end="\#endif" transparent fold
