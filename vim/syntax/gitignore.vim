" Bradford Smith
" ~/.vim/syntax/gitignore.vim
" 07/21/2016
" Custom .gitignore syntax for Vim

if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

syn match gitignoreComment "^#.*"
syn match gitignoreSpecial "^!.*"
syn match gitignoreDirectory "^\(#\|!\)\@!.*/$"

hi def link gitignoreComment Comment
hi def link gitignoreSpecial Special
hi def link gitignoreDirectory Directory

let b:current_syntax = "gitignore"
