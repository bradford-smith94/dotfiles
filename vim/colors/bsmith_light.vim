" Vim coloscheme file
" Bradford Smith
" bsmith_light.vim
" updated: 09/27/2015
"=====================

"This is the light colors variant of my custom colorscheme

"vim things
hi Normal ctermfg=16 ctermbg=230
hi Cursor ctermfg=15 ctermbg=16
hi CursorLine cterm=none ctermbg=255
hi link CursorColumn CursorLine
hi LineNR ctermfg=16 ctermbg=255
hi CursorLineNR cterm=bold ctermfg=208 ctermbg=230
hi link ColorColumn CursorColumn
hi Visual cterm=reverse
hi VisualNOS ctermbg=239
hi SignColumn ctermfg=118 ctermbg=235
hi Title ctermfg=202
hi Label ctermfg=228
hi Directory ctermfg=118
hi MatchParen cterm=bold ctermfg=1
hi Special ctermfg=161
hi link SpecialChar Special
hi SpecialKey ctermfg=34
hi link Tag Special
hi Delimiter ctermfg=75
hi link Question SpecialKey
hi Underlined cterm=underline

"messages
hi Error ctermbg=9
hi link ErrorMsg Error
hi WarningMsg ctermfg=11
hi MoreMsg ctermfg=243
hi link ModeMsg MoreMsg
hi StatusLine ctermfg=253 ctermbg=238
hi StatusLineNC ctermfg=232 ctermbg=244
hi TabLine cterm=underline ctermfg=0 ctermbg=7
hi TabLineSel cterm=bold
hi TabLineFill cterm=reverse

"menus
hi WildMenu ctermfg=156 ctermbg=16
hi Folded ctermfg=67 ctermbg=16
hi link FoldColumn Folded
hi PMenu ctermfg=156 ctermbg=240
hi PMenuSel cterm=bold ctermfg=156 ctermbg=235
hi PMenuSBar ctermfg=255 ctermbg=237
hi PMenuThumb ctermfg=156 ctermbg=237
hi VertSplit cterm=bold ctermfg=244

"searching and spelling
hi Search ctermfg=0 ctermbg=222
hi IncSearch ctermfg=16 ctermbg=193
hi SpellBad cterm=underline ctermfg=160 ctermbg=253
hi SpellCap cterm=underline ctermfg=21 ctermbg=253
hi SpellRare cterm=underline ctermfg=165 ctermbg=253
hi SpellLocal cterm=underline ctermfg=91 ctermbg=253
hi link SyntasticError SpellBad
hi link SyntasticWarning WarningMsg
hi link SyntasticStyleError SyntasticError
hi link SyntasticStyleWarning SyntasticWarning

"vimdiff colors
hi DiffAdd ctermfg=174 ctermbg=28
hi DiffChange ctermfg=174 ctermbg=24
hi DiffDelete ctermbg=52
hi DiffText ctermfg=24 ctermbg=244

"comments
hi Comment ctermfg=6
hi SpecialComment ctermfg=39
hi TODO cterm=bold ctermfg=232 ctermbg=11
hi NonText ctermfg=59
hi link Ignore NonText
hi Conceal ctermfg=7 ctermbg=242

"types
hi Type ctermfg=34
hi String ctermfg=28
hi Character ctermfg=9
hi Constant ctermfg=172
hi link Boolean Constant
hi Number ctermfg=91
hi link Float Number
hi Structure cterm=bold ctermfg=4
hi link Typedef Structure
hi StorageClass ctermfg=208

"other programming language constructs
hi Function cterm=bold ctermfg=75
hi Keyword ctermfg=172
hi Identifier ctermfg=10
hi Conditional cterm=bold ctermfg=172
hi link Repeat Conditional
hi Statement ctermfg=9
hi link Operator Normal
hi Debug ctermfg=219
hi Define cterm=bold ctermfg=81
hi link Macro Define
hi PreCondit cterm=bold ctermfg=4
hi PreProc ctermfg=161
hi Exception ctermfg=21 ctermbg=237

