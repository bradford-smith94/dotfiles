if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

syn match gitignoreComment "#.*"

hi def link gitignoreComment Comment

let b:current_syntax = "gitignore"
