" Bradford Smith
" ~/.vim/autoload/dauber/config.vim
" 10/02/2017
" Settings to define colors for the dauber plugin

function! dauber#config#SetColors()
    if &t_Co >= 256 || has('gui_running')
        "{{{
        "normal mode colors (green)
        highlight StatN1 guifg=#000000 guibg=#87ff00 ctermfg=16 ctermbg=118
        highlight StatN2 guifg=#87ff00 guibg=#303030 ctermfg=118 ctermbg=236
        highlight StatN3 guifg=#87ff87 guibg=#303030 ctermfg=120 ctermbg=236
        "insert mode colors (blue)
        highlight StatI1 guifg=#000000 guibg=#00d7ff ctermfg=16 ctermbg=45
        highlight StatI2 guifg=#00d7ff guibg=#303030 ctermfg=45 ctermbg=236
        highlight StatI3 guifg=#00ffff guibg=#303030 ctermfg=51 ctermbg=236
        "replace mode colors (red)
        highlight StatR1 guifg=#dadada guibg=#af0000 ctermfg=253 ctermbg=124
        highlight StatR2 guifg=#af0000 guibg=#303030 ctermfg=124 ctermbg=236
        highlight StatR3 guifg=#ff0000 guibg=#303030 ctermfg=196 ctermbg=236
        "visual mode colors (orange)
        highlight StatV1 guifg=#000000 guibg=#ff8700 ctermfg=16 ctermbg=208
        highlight StatV2 guifg=#ff8700 guibg=#303030 ctermfg=208 ctermbg=236
        highlight StatV3 guifg=#ffaf5f guibg=#303030 ctermfg=215 ctermbg=236

        "read only flag (red)
        highlight StatFlag guifg=#ff0000 guibg=#303030 ctermfg=196 ctermbg=236
        "}}}
    elseif &t_Co == 16
        "{{{
        "normal mode colors (green)
        highlight StatN1 ctermfg=0 ctermbg=10
        highlight StatN2 ctermfg=10 ctermbg=6
        highlight StatN3 ctermfg=10 ctermbg=6
        "insert mode colors (blue)
        highlight StatI1 ctermfg=0 ctermbg=14
        highlight StatI2 ctermfg=14 ctermbg=6
        highlight StatI3 ctermfg=14 ctermbg=6
        "replace mode colors (red)
        highlight StatR1 ctermfg=15 ctermbg=1
        highlight StatR2 ctermfg=1 ctermbg=6
        highlight StatR3 ctermfg=9 ctermbg=6
        "visual mode colors (orange)
        highlight StatV1 ctermfg=0 ctermbg=3
        highlight StatV2 ctermfg=3 ctermbg=6
        highlight StatV3 ctermfg=11 ctermbg=6

        "read only flag (red)
        highlight StatFlag ctermfg=9 ctermbg=6
        "}}}
    elseif &t_Co == 8
        "{{{
        "normal mode colors (green)
        highlight StatN1 ctermfg=0 ctermbg=2
        highlight StatN2 ctermfg=2 ctermbg=6
        highlight StatN3 ctermfg=2 ctermbg=6
        "insert mode colors (blue)
        highlight StatI1 ctermfg=0 ctermbg=6
        highlight StatI2 ctermfg=6 ctermbg=4
        highlight StatI3 ctermfg=6 ctermbg=4
        "replace mode colors (red)
        highlight StatR1 ctermfg=7 ctermbg=1
        highlight StatR2 ctermfg=1 ctermbg=6
        highlight StatR3 ctermfg=1 ctermbg=6
        "visual mode colors (orange)
        highlight StatV1 ctermfg=0 ctermbg=3
        highlight StatV2 ctermfg=3 ctermbg=6
        highlight StatV3 ctermfg=3 ctermbg=6

        "read only flag (red)
        highlight StatFlag ctermfg=1 ctermbg=6
        "}}}
    endif

    "dauber color group settings
    let g:dauber_normal_groups = ['StatN1', 'StatN2', 'StatN3', 'None', 'None',
                \ 'None', 'None', 'None', 'StatFlag']
    let g:dauber_insert_groups = ['StatI1', 'StatI2', 'StatI3', 'None', 'None',
                \ 'None', 'None', 'None', 'StatFlag']
    let g:dauber_replace_groups = ['StatR1', 'StatR2', 'StatR3', 'None', 'None',
                \ 'None', 'None', 'None', 'StatFlag']
    let g:dauber_visual_groups = ['StatV1', 'StatV2', 'StatV3', 'None', 'None',
                \ 'None', 'None', 'None', 'StatFlag']
    let g:dauber_visual_line_groups = ['StatV1', 'StatV2', 'StatV3', 'None', 'None',
                \ 'None', 'None', 'None', 'StatFlag']
    let g:dauber_visual_block_groups = ['StatV1', 'StatV2', 'StatV3', 'None', 'None',
                \ 'None', 'None', 'None', 'StatFlag']
endfunction
