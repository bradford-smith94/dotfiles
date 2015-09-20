" Vim colorscheme file
" Bradford Smith
" updated: 09/20/2015
"=====================

"This was started by following the guide at:
"http://vim.wikia.com/wiki/Create_a_color_scheme_based_on_another
"TODO: maybe add 16/8-color terminal support
"TODO: add non-color terminal support
"TODO: add GVim support

"these lines are suggested to be at the top of every colorscheme
hi clear
if exists("syntax_on")
    syntax reset
endif

"set the name of the colorscheme
let g:colors_name = "bsmith"

"use my custom airline theme too
let g:airline_theme = "bsmith_airline"

"--clear everything manually (fixes some errors with things being defaulted)
hi clear Normal
hi clear Cursor
hi clear CursorLine
hi clear CursorColumn
hi clear LineNr
hi clear CursorLineNR
hi clear ColorColumn
hi clear Visual
hi clear VisualNOS
hi clear SignColumn
hi clear Title
hi clear Label
hi clear Directory
hi clear MatchParen
hi clear Special
hi clear SpecialChar
hi clear SpecialKey
hi clear Tag
hi clear Delimiter
hi clear Question
hi clear Underlined

hi clear Error
hi clear ErrorMsg
hi clear WarningMsg
hi clear MoreMsg
hi clear ModeMsg
hi clear StatusLine
hi clear StatusLineNC
hi clear TabLine
hi clear TabLineSel
hi clear TabLineFill

hi clear WildMenu
hi clear Folded
hi clear FoldColumn
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
hi clear SyntasticError
hi clear SyntasticWarning
hi clear SyntasticStyleError
hi clear SyntasticStyleWarning

hi clear DiffAdd
hi clear DiffChange
hi clear DiffDelete
hi clear DiffText

hi clear Comment
hi clear SpecialComment
hi clear TODO
hi clear NonText
hi clear Ignore
hi clear Conceal

hi clear Type
hi clear String
hi clear Character
hi clear Constant
hi clear Boolean
hi clear Number
hi clear Float
hi clear Structure
hi clear Typedef
hi clear StorageClass

hi clear Function
hi clear Keyword
hi clear Identifier
hi clear Conditional
hi clear Repeat
hi clear Statement
hi clear Operator
hi clear Debug
hi clear Define
hi clear Macro
hi clear PreCondit
hi clear PreProc
hi clear Exception

if has("gui_running")
    echo "bsmith.vim does not currently support GVim"
elseif &t_Co >= 256 "this is a 256 or greater color terminal
    if &background == "dark" "dark theme colors

        "vim things
        hi Normal ctermfg=252 ctermbg=233
        hi Cursor ctermfg=16 ctermbg=253
        hi CursorLine cterm=none ctermbg=236
        hi link CursorColumn CursorLine
        hi LineNR ctermfg=250 ctermbg=236
        hi CursorLineNR cterm=bold ctermfg=208 ctermbg=233
        hi link ColorColumn CursorColumn
        hi Visual cterm=reverse
        hi VisualNOS ctermbg=239
        hi SignColumn ctermfg=118 ctermbg=235
        hi Title ctermfg=166
        hi Label ctermfg=228
        hi Directory ctermfg=118
        hi MatchParen cterm=bold ctermfg=1
        hi Special ctermfg=161
        hi link SpecialChar Special
        hi SpecialKey ctermfg=120
        hi link Tag Special
        hi Delimiter ctermfg=81
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
        hi SpellBad cterm=underline ctermfg=160
        hi SpellCap cterm=underline ctermfg=21
        hi SpellRare cterm=underline ctermfg=165
        hi SpellLocal cterm=underline ctermfg=91
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
        hi TODO cterm=bold ctermfg=11 ctermbg=232
        hi NonText ctermfg=59
        hi link Ignore NonText
        hi Conceal ctermfg=7 ctermbg=242

        "types
        hi Type ctermfg=112
        hi String ctermfg=28
        hi Character ctermfg=9
        hi Constant ctermfg=227
        hi link Boolean Constant
        hi Number ctermfg=133
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

        "work around for background getting set to light
        set background=dark

    else "light theme colors

        "vim things
        hi Normal ctermfg=16 ctermbg=230
        hi Cursor ctermfg=15 ctermbg=16
        hi CursorLine cterm=none ctermbg=255
        hi link CursorColumn CursorLine
        hi LineNR ctermfg=250 ctermbg=236
        hi CursorLineNR cterm=bold ctermfg=208 ctermbg=233
        hi link ColorColumn CursorColumn
        hi Visual cterm=reverse
        hi VisualNOS ctermbg=239
        hi SignColumn ctermfg=118 ctermbg=235
        hi Title ctermfg=166
        hi Label ctermfg=228
        hi Directory ctermfg=118
        hi MatchParen cterm=bold ctermfg=1
        hi Special ctermfg=161
        hi link SpecialChar Special
        hi SpecialKey ctermfg=120
        hi link Tag Special
        hi Delimiter ctermfg=81
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
        hi TODO cterm=bold ctermfg=11 ctermbg=232
        hi NonText ctermfg=59
        hi link Ignore NonText
        hi Conceal ctermfg=7 ctermbg=242

        "types
        hi Type ctermfg=34
        hi String ctermfg=28
        hi Character ctermfg=9
        hi Constant ctermfg=227
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

    endif "end if background dark/light
endif "end if colors gui/256
