" Vim colorscheme file
" Bradford Smith
" bsmith.vim
" updated: 09/25/2015
"=====================

"This was started by following the guide at:
"http://vim.wikia.com/wiki/Create_a_color_scheme_based_on_another
"TODO: move color count checks to dark/light files
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
        source ~/.vim/colors/bsmith_dark.vim
    else "light theme colors
        source ~/.vim/colors/bsmith_light.vim
    endif "end if background dark/light
endif "end if colors gui/256
