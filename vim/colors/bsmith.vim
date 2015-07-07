" Vim colorscheme file
" Author: Bradford Smith
" Email: <bradford.smith94@gmail.com>
" See: vim.wikia.com/wiki/Create_a_color_scheme_based_on_another
" Date: 7/6/2015
"=====================================

"these lines are suggested to be at the top of every colorscheme
hi clear
if exists("syntax_on")
    syntax reset
endif

"Load the 'base' colorscheme
runtime colors/molokai.vim

"Override the name of the base colorscheme
let g:colors_name = "bsmith"
let g:airline_theme = "bsmith_airline" "custom airline theme

"--clear the colors for items that will be changed
"slowly making this a standalone colorscheme

"vim things
hi clear Normal
hi clear Cursor
hi clear LineNR
hi clear CursorLine
hi clear CursorLineNR
hi clear Visual
hi clear VisualNOS
hi clear MatchParen
hi clear Title
hi clear Directory
hi clear Error
hi clear ErrorMsg
hi clear WarningMsg
hi clear MoreMsg
hi clear ModeMsg
hi clear Special
hi clear SpecialChar
hi clear SpecialKey
hi clear Delimiter
hi clear Question

hi clear WildMenu
hi clear PMenu
hi clear PMenuSel
hi clear PMenuSBar
hi clear PMenuThumb
hi clear VertSplit

hi clear Search
hi clear IncSearch

hi clear SpellBad
hi clear SpellCap
hi clear SpellRare
hi clear SpellLocal

"vimdiff colors
hi clear DiffAdd
hi clear DiffChange
hi clear DiffDelete
hi clear DiffText

"comments
hi clear Comment
hi clear SpecialComment
hi clear TODO
hi clear NonText

"types
hi clear String
hi clear Character
hi clear Constant
hi clear Boolean
hi clear Number
hi clear Float
hi clear Type

"other language constructs
hi clear Function
hi clear Keyword
hi clear Identifier
hi clear Conditional
hi clear Repeat
hi clear Statement
hi clear Debug
hi clear Operator
hi clear Define
hi clear Macro
hi clear PreCondit
hi clear PreProc
hi clear Exception
hi clear Structure
hi clear Typedef

"--set new colors to cleared items

"vim things
hi Normal ctermfg=252 ctermbg=233
hi Cursor ctermfg=16 ctermbg=253
hi LineNR ctermfg=250 ctermbg=236
hi CursorLine cterm=bold ctermbg=234
hi CursorLineNR cterm=bold ctermfg=208 ctermbg=233
hi Visual cterm=reverse
hi VisualNOS ctermbg=239
hi Title ctermfg=166
hi Directory ctermfg=118
hi MatchParen cterm=bold ctermfg=233 ctermbg=1
hi Error ctermbg=9
hi link ErrorMsg Error
hi WarningMsg ctermfg=11
hi MoreMsg ctermfg=243
hi link ModeMsg MoreMsg
hi Special ctermfg=161
hi link SpecialChar Special
hi SpecialKey ctermfg=120
hi Delimiter ctermfg=81
hi link Question SpecialKey

hi WildMenu ctermfg=156 ctermbg=16
hi PMenu ctermfg=156 ctermbg=240
hi PMenuSel cterm=bold ctermfg=156 ctermbg=235
hi PMenuSBar ctermfg=255 ctermbg=237
hi PMenuThumb ctermfg=156 ctermbg=237
hi VertSplit cterm=bold ctermfg=244

hi Search ctermfg=0 ctermbg=222
hi IncSearch ctermfg=16 ctermbg=193

hi SpellBad ctermbg=52
hi SpellCap ctermbg=17
hi SpellRare cterm=reverse ctermbg=17
hi SpellLocal cterm=underline ctermbg=17

"vimdiff colors
hi DiffAdd ctermfg=174 ctermbg=28
hi DiffChange ctermfg=174 ctermbg=24
hi DiffDelete ctermbg=52
hi DiffText ctermfg=24 ctermbg=244

"comments
hi Comment ctermfg=6
hi SpecialComment ctermfg=39
hi TODO cterm=bold ctermfg=11 ctermbg=232
hi NonText ctermfg=59

"types
hi String ctermfg=28
hi Character ctermfg=9
hi Constant ctermfg=227
hi link Boolean Constant
hi Number ctermfg=133
hi link Float Number
hi Type ctermfg=10

"other language constructs
hi Function ctermfg=112
hi Keyword ctermfg=172
hi Identifier ctermfg=10
hi Conditional cterm=bold ctermfg=172
hi link Repeat Conditional
hi Statement ctermfg=9
hi Debug ctermfg=219
hi Define cterm=bold ctermfg=81
hi link Macro Define
hi PreCondit cterm=bold ctermfg=4
hi PreProc ctermfg=161
hi Exception ctermfg=21 ctermbg=237
hi Structure cterm=bold ctermfg=4
hi link Typedef Structure
