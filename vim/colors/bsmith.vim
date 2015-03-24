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
hi clear Keyword
hi clear Conditional
hi clear Statement
hi clear Error
hi clear Operator
hi clear PreProc

"Set up your new & improved colors
hi Comment ctermfg=darkcyan
hi String ctermfg=darkgreen
hi Keyword ctermfg=yellow
hi Conditional cterm=bold ctermfg=yellow
hi Statement cterm=bold ctermfg=red
hi Error ctermbg=red
hi PreProc cterm=bold ctermfg=161
