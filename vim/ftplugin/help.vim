" Bradford Smith
" ~/.vim/ftplugin/help.vim
" 11/11/2017
" Help filetype specific configuration
" see: vim.wikia.com/wiki/Learn_to_use_help

"settings
setlocal nospell
setlocal keywordprg=:help

"mappings

"Enter <CR> jumps to the subject under the cursor
nnoremap <buffer> <CR> <C-]>
"Backspace <BS> jumps back
nnoremap <buffer> <BS> <C-T>
"o finds next option
nnoremap <buffer> o /'\l\{2,\}'<CR>
"O finds previous option
nnoremap <buffer> O ?'\l\{2,\}'<CR>
"q quits
nnoremap <buffer> q :q<CR>
"s finds next subject
nnoremap <buffer> s /\|\zs\S\+\ze\|<CR>
"S finds previous subject
nnoremap <buffer> S ?\|\zs\S\+\ze\|<CR>
