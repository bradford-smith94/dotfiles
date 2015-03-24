" Vim color file
" Author: Bradford Smith
" <bradford.smith94@gmail.com>
" Date: 3/24/15
"=============================

"these lines are suggested to be at the top of every colorscheme
hi clear
if exists("syntax_on")
	syntax reset
endif

"Load the 'base' colorscheme - the one you want to alter
runtime colors/molokai.vim

"Override the name of the base colorscheme with the name of this custom one
let g:colors_name = "bsmith"

"Clear the colors for any items that you don't like
hi clear Comment
hi clear String
hi clear Character
hi clear Boolean
hi clear Number
hi clear Keyword
hi clear Conditional
hi clear Repeat
hi clear Statement
hi clear Error
hi clear Operator
hi clear PreCondit
hi clear PreProc
hi clear Type
hi clear SpecialKey

"Set up your new & improved colors
hi Comment ctermfg=darkcyan
hi String ctermfg=darkgreen
hi Character ctermfg=red
hi link Boolean Constant
hi link Number Constant
hi Keyword ctermfg=172
hi Conditional cterm=bold ctermfg=172
hi Repeat cterm=bold ctermfg=172
hi Statement ctermfg=red
hi Error ctermbg=red
hi PreCondit cterm=bold ctermfg=darkcyan
hi PreProc cterm=bold ctermfg=161
hi Type cterm=bold ctermfg=green
hi SpecialKey ctermfg=lightgreen
