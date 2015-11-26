" Vim colors theme for vim-airline
" Bradford Smith
" bsmith_dark.vim
" updated: 11/25/2015
""""""""""""""""""""""""""""""""""""""

let g:airline#themes#bsmith_dark#palette = {}

" [ guifg, guibg, ctermfg, ctermbg, opts ]. See "help attr-list" for valid
" values for the "opt" value.

"NORMAL
let s:N1   = [ '#121212' , '#87ff00' , 233 , 118 ]
let s:N2   = [ '#ffffff' , '#444444' , 255 , 238 ]
let s:N3   = [ '#2bfc6f' , '#202020' , 83  , 234 ]
let g:airline#themes#bsmith_dark#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#bsmith_dark#palette.normal_modified = {
      \ 'airline_c': [ '#006006' , '#bcbcbc' , 22      , 250     , ''     ] ,
      \ }

"INSERT
let s:I1 = [ '#00005f' , '#00dfff' , 17  , 45  ]
let s:I2 = [ '#ffffff' , '#005fff' , 255 , 27  ]
let s:I3 = [ '#ffffff' , '#00005f' , 255 , 17  ]
let g:airline#themes#bsmith_dark#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
let g:airline#themes#bsmith_dark#palette.insert_modified = {
      \ 'airline_c': [ '#00005f' , '#bcbcbc' , 17      , 250     , ''     ] ,
      \ }
let g:airline#themes#bsmith_dark#palette.insert_paste = {
      \ 'airline_a': [ s:I1[0]   , '#d78700' , s:I1[2] , 172     , ''     ] ,
      \ }

"REPLACE
let s:R1 = [ 'ffffff' , 'ff0000' , 255 , 196 ]
let s:R2 = [ 'ffffff' , 'af0000' , 255 , 124 ]
let s:R3 = [ 'ffffff' , '5f0000' , 255 , 52  ]
let g:airline#themes#bsmith_dark#palette.replace = airline#themes#generate_color_map(s:R1, s:R2, s:R3)
let g:airline#themes#bsmith_dark#palette.replace_modified = {
      \ 'airline_c': [ '#5f0000' , '#bcbcbc' , 52      , 250     , ''     ] ,
      \ }

"VISUAL
let s:V1 = [ '#5f0000' , '#ffaf00' , 52  , 214 ]
let s:V2 = [ '#5f0000' , '#ff5f00' , 52  , 202 ]
let s:V3 = [ '#ffffff' , '#5f0000' , 255 , 52  ]
let g:airline#themes#bsmith_dark#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
let g:airline#themes#bsmith_dark#palette.visual_modified = {
      \ 'airline_c': [ '#5f0000' , '#bcbcbc' , 52      , 250     , ''     ] ,
      \ }

"INACTIVE
let s:IA1 = [ '#58d7ad' , '#1c1c1c' , 115 , 234 , '' ]
let s:IA2 = [ '#58d7ad' , '#262626' , 115 , 235 , '' ]
let s:IA3 = [ '#58d7ad' , '#303030' , 115 , 236 , '' ]
let g:airline#themes#bsmith_dark#palette.inactive = airline#themes#generate_color_map(s:IA1, s:IA2, s:IA3)
let g:airline#themes#bsmith_dark#palette.inactive_modified = {
      \ 'airline_c': [ '#875faf' , '' , 97 , '' , '' ] ,
      \ }

"accent color, used by the READONLY notifier
let g:airline#themes#bsmith_dark#palette.accents = {
  \ 'red': [ '#ff0000' , '' , 160 , ''  ]
  \ }

"CTRLP
if !get(g:, 'loaded_ctrlp', 0)
finish
endif
let g:airline#themes#bsmith_dark#palette.ctrlp = airline#extensions#ctrlp#generate_color_map(
  \ [ '#d7d7ff' , '#5f00af' , 189 , 55  , ''     ],
  \ [ '#ffffff' , '#875fd7' , 231 , 98  , ''     ],
  \ [ '#5f00af' , '#ffffff' , 55  , 231 , 'bold' ])

