" Vim coloscheme file
" Bradford Smith
" bsmith_light.vim
" updated: 10/29/2015
"=====================
"TODO: airline colors light

"This is the light colors variant of my custom colorscheme

if has("gui_running")
    echo "bsmith_light.vim does not currently support GVim"
elseif &t_Co >= 256 "this is a 256 or greater color terminal
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
    hi Structure cterm=bold ctermfg=34
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
    hi Define cterm=bold ctermfg=75
    hi link Macro Define
    hi PreCondit cterm=bold ctermfg=4
    hi PreProc ctermfg=161
    hi Exception ctermfg=21

endif
