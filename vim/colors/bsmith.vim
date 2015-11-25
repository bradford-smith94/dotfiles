" Vim colorscheme file
" Bradford Smith
" bsmith.vim
" updated: 11/25/2015
"=====================

"This was started by following the guide at:
"http://vim.wikia.com/wiki/Create_a_color_scheme_based_on_another
"TODO: maybe add 16/8-color terminal support
"TODO: add non-color terminal support
"TODO: add GVim support

"{{{--required colorscheme lines ==============================================
hi clear
if exists("syntax_on")
    syntax reset
endif

"set the name of the colorscheme
let g:colors_name = "bsmith"

"use my custom airline theme too
let g:airline_theme = "bsmith_airline"
"}}}===========================================================================

"{{{--clear everything manually (fixes some errors) ===========================
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
"}}}===========================================================================

let s:m = ' cterm'
let s:mfg = s:m . "fg="
let s:mbg = s:m . "bg="
let s:b = s:m . "=bold"
let s:r = s:m . "=reverse"
let s:u = s:m . "=underline"

"{{{--define colors ===========================================================
let s:black = '16 '
let s:pale_blue = '67 '
let s:light_grey = '243 '
let s:grey = '238 '
let s:lime = '118 '
let s:light_lime = '156 '
let s:orange = '208 '
let s:dark_orange = '202 '
let s:pink = '161 '
let s:red = '160 '
let s:bright_red = '196 '
let s:white = '253 '
let s:yellow = '11 ' "maybe 226?
let s:light_yellow = '228 '

"{{{-dark/light colors
if &background == "dark" "dark theme colors
    let s:bg = '233 '
    let s:fg = '252 '
    let s:cursor = s:white
    let s:highlight = '236 '
    let s:special_key = '120 '
    let s:light_blue = '81 '
    let s:warn = s:yellow
else "light theme colors
    let s:bg = '230 '
    let s:fg = s:black
    let s:cursor = s:black
    let s:highlight = s:white
    let s:special_key = '34 '
    let s:light_blue = '75 '
    let s:warn = '165 '
endif "end if background dark/light
"}}}
"}}}===========================================================================

"{{{--do highlights ===========================================================
"{{{-vim things
exe "hi Normal" . s:mfg . s:fg . s:mbg . s:bg
exe "hi Cursor" . s:mfg . s:cursor . s:mbg . s:fg
exe "hi CursorLine" . s:mbg . s:highlight
hi link CursorColumn CursorLine
exe "hi LineNR" . s:mfg . s:fg . s:mbg . s:highlight
exe "hi CursorLineNR" . s:b . s:mfg . s:orange . s:mbg . s:highlight
hi link ColorColumn CursorColumn
exe "hi Visual" . s:r
exe "hi VisualNOS" . s:mbg . s:highlight
exe "hi SignColumn" . s:mfg . s:lime . s:mbg . s:highlight
exe "hi Title" . s:mfg . s:dark_orange
exe "hi Label" . s:mfg . s:light_yellow
exe "hi Directory" . s:mfg . s:lime
exe "hi MatchParen" . s:b . s:mfg . s:red
exe "hi Special" . s:mfg . s:pink
hi link SpecialChar Special
hi link Tag Special
exe "hi SpecialKey" . s:mfg . s:special_key
hi link Question SpecialKey
exe "hi Delimiter" . s:mfg . s:light_blue
exe "hi Underlined" . s:u
"}}}

"{{{-messages
exe "hi Error" . s:mbg . s:bright_red
hi link ErrorMsg Error
exe "hi WarningMsg" . s:mfg . s:warn . s:mbg . s:highlight
exe "hi MoreMsg" . s:mfg . s:light_grey
hi link ModeMsg MoreMsg
"}}}

"{{{-menus/ui
exe "hi StatusLine" . s:mfg . s:white . s:mbg . s:grey
exe "hi StatusLineNC" . s:mfg . s:black . s:mbg . s:light_grey
exe "hi Tabline" . s:u . s:mfg . s:black . s:mbg . s:white
exe "hi TablineSel" . s:b
exe "hi TabLineFill" . s:r
exe "hi WildMenu" . s:mfg . s:light_lime . s:mbg . s:grey
exe "hi Folded" . s:mfg . s:pale_blue . s:mbg . s:black
hi link FoldColumn Folded
exe "hi PMenu" . s:mfg . s:light_lime . s:mbg . s:light_grey
hi link PMenuThumb PMenu
exe "hi PMenuSel" . s:b . s:mfg . s:light_lime . s:mbg . s:grey
exe "hi PMenuSBar" . s:mfg . s:white . s:mbg . s:grey
exe "hi VertSplit" . s:mfg . s:light_grey
"}}}

"{{{-searching/spelling
exe "hi Search" . s:mfg . s:black . s:mbg . s:light_yellow
"}}}
"}}}===========================================================================

