" Bradford Smith
" 08/14/2016
" ~/.vim/after/ftplugin/markdown.vim
" Markdown filetype specific configuration to run after system configuration

"settings
setlocal wrap
setlocal spell
setlocal formatoptions-=tc
setlocal omnifunc=htmlcomplete#CompleteTags

"mappings
if executable('pandoc') == 1
    noremap <buffer> <F5> :w<CR>:execute "!pandoc -s -t latex -o ".expand("%:r").".pdf ".expand("%")<CR>
    inoremap <buffer> <F5> <Esc>:w<CR>:execute "!pandoc -s -t latex -o ".expand("%:r").".pdf ".expand("%")<CR>
endif

"vim-autolist mappings
imap <buffer> <CR> <Esc><Plug>AutolistReturn
nmap <buffer> o <Plug>AutolistNewLineBelow
nmap <buffer> O <Plug>AutolistNewLineAbove

"source typo autocorrection
source ~/.vim/custom/typo_autocorrect.vim
