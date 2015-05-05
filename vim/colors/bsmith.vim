" Vim color file
" Author: Bradford Smith
" <bradford.smith94@gmail.com>
" Date: 4/28/15
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
"slowly making this a standalone colorscheme
hi clear Normal
hi clear Cursor
hi clear CursorLine
hi clear Comment
hi clear TODO
hi clear String
hi clear Character
hi clear Constant
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
hi clear LineNR
hi clear CursorLineNR
hi clear Visual

"Set up your new & improved colors
hi Normal ctermfg=252 ctermbg=233
hi Cursor ctermfg=16 ctermbg=253
hi CursorLine cterm=bold ctermbg=234
hi Comment ctermfg=6
hi TODO cterm=bold ctermfg=11 ctermbg=232
hi String ctermfg=28
hi Character ctermfg=9
hi Constant ctermfg=133
hi link Boolean Constant
hi link Number Constant
hi Keyword ctermfg=172
hi Conditional cterm=bold ctermfg=172
hi Repeat cterm=bold ctermfg=172
hi Statement ctermfg=9
hi Error ctermbg=9
hi PreCondit cterm=bold ctermfg=9
hi PreProc ctermfg=161
hi Type ctermfg=10
hi SpecialKey ctermfg=120
hi LineNR ctermfg=250 ctermbg=236
hi CursorLineNR cterm=bold ctermfg=208 ctermbg=233
hi Visual cterm=reverse
