" Bradford Smith
" ~/.vim/syntax/gitblame.vim
" 2020-05-26
" Custom Git Blame syntax for Vim

if version < 600
    syntax clear
elseif exists('b:current_syntax')
    finish
endif

runtime! syntax/git.vim

syntax match gitHash /^\^\x\{39\}\>/ containedin=gitHead
syntax match gitHash /^\x\{40\}\>/ containedin=gitHead
syntax match gitUncommittedChange /^0\{40\}\>/ containedin=gitHash

syntax region gitAuthorTimestamp start=/(/ end=/)/ containedin=gitHead

highlight default link gitUncommittedChange NonText
highlight default link gitAuthorTimestamp Statement

let b:current_syntax = 'gitblame'
