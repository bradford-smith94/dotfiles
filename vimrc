" Bradford Smith
" .vimrc
" updated: 02/01/2017
"""""""""""""""""""""

"{{{-core stuff-----------------------------------------------------------------
set encoding=utf-8 "use UTF-8 internally
set nospell "spelling off by default
set spelllang=en_us
set spellfile=~/.vim/spell/custom.utf-8.add
silent! mkspell! ~/.vim/spell/custom.utf-8.add
set backspace=indent,eol,start "makes backspace work like expected
set noerrorbells
set visualbell
set t_vb=
set viminfo='100,<50,s10,/0,h,n~/.vim/viminfo "see :help 'viminfo'
set nomodeline "disable modelines
set notimeout "don't timeout on :mappings
set ttimeout "timeout on key codes (like esc and arrow keys)
set ttimeoutlen=50 "esc and arrows timeout
set mouse=nr "normal and 'Hit Enter' messages (useful for switching windows)
let $MANPAGER='' "allows Vim's :Man command to be used without conflict
"}}}----------------------------------------------------------------------------


"{{{-setup vundle to manage plugins---------------------------------------------
"automatically install vundle if not present
"credit: github.com/timss/vimconf
let has_vundle=1
if !filereadable(glob("~/.vim/bundle/Vundle.vim/README.md"))
    echo "Installing Vundle..."
    echo ""
    silent !mkdir -p $HOME/.vim/bundle
    silent !git clone
        \ https://github.com/VundleVim/Vundle.vim $HOME/.vim/bundle/Vundle.vim
    let has_vundle=0
endif

"initialize vundle
filetype off
set rtp+=$HOME/.vim/bundle/Vundle.vim

call vundle#begin()
"plugins '<github_user>/<repo>' or full git path
Plugin 'VundleVim/Vundle.vim' "originally gmarik/Vundle.vim
Plugin 'bradford-smith94/vim-autolist' "automatic list continuation
Plugin 'bradford-smith94/vim-colors-bsmith'
Plugin 'bradford-smith94/vim-superupdate' "automatic plugin updating
if executable('editorconfig')
    Plugin 'editorconfig/editorconfig-vim' "support for editorconfig
endif
Plugin 'EinfachToll/DidYouMean'
Plugin 'honza/vim-snippets'
Plugin 'konfekt/fastfold'
Plugin 'mgrabovsky/vim-xverif'
Plugin 'nelstrom/vim-markdown-folding'
Plugin 'nikvdp/ejs-syntax'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'runoshun/vim-alloy'
if has("patch-7.3-885") && has("lua") "neocomplete requires v7.3.885 and +lua
    Plugin 'shougo/neocomplete'
endif
if v:version >= 704 && (has("python") || has("python3"))
    Plugin 'SirVer/ultisnips'
endif
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-speeddating' "allow <C-a>/<C-x> to work for dates and times
Plugin 'tpope/vim-surround' "surroundings motions
Plugin 'tpope/vim-unimpaired' "additional bracket pair mappings
Plugin 'tpope/vim-repeat' "allow repeating of surround and speeddating
Plugin 'unblevable/quick-scope' "highlight unique targets for (f, F, etc)
Plugin 'vim-syntastic/syntastic' "originally scrooloose/syntastic
Plugin 'Yggdroot/indentLine'
call vundle#end()

"felt like these belonged with plugin initialization
source $VIMRUNTIME/ftplugin/man.vim "initializes the :Man command
runtime macros/matchit.vim "sources extended mappings for '%'

"if this is the first time vundle is installed
if has_vundle == 0
    echo "Initial Plugin install please wait..."
    "install the plugins
    silent! PluginInstall

    qa "quit after installing everything
endif

"turn filetype back on (was turned off to do Vundle things)
filetype indent plugin on
"}}}----------------------------------------------------------------------------


"{{{-plugin settings------------------------------------------------------------
let g:netrw_banner = 0
let g:netrw_winsize = -30

let g:syntastic_javascript_checkers = ["eslint"]
let g:syntastic_html_checkers = ["validator"]
let g:syntastic_mode_map = {
            \ "mode": "active",
            \ "active_filetypes": [],
            \ "passive_filetypes": ["ejs", "html"] }

if has("patch-7.3-885") && has("lua") "neocomplete requires v7.3.885 and +lua
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#enable_auto_close_preview = 1
endif

"only do quick-scope highlighting after pressing f, F, t and T keys
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:qs_first_occurrence_highlight_color = 81
let g:qs_second_occurrence_highlight_color = 161

if has("python") || has("python3")
    let g:UltiSnipsExpandTrigger = "<Tab>"
    "let g:UltiSnipsListSnippets = "<C-Tab>"
    let g:UltiSnipsJumpForwardTrigger = "<Tab>"
    let g:UltiSnipsJumpBackwardTrigger = "<S-Tab>"
endif

if has("patch-7.3-885") && has("lua") "neocomplete requires v7.3.885 and +lua
    "Backspace closes popup
    inoremap <expr><BS> neocomplete#smart_close_popup() ."\<C-h>"
endif

"only enable indentLine for some filetypes
let g:indentLine_fileType = ['html', 'xhtml', 'xml']
"}}}----------------------------------------------------------------------------


"{{{-visual stuff---------------------------------------------------------------
if has("syntax")
    syntax on
    set cursorline "highlight the line the cursor is on
    augroup cursorline_group
        autocmd!
        autocmd WinEnter,BufEnter * setlocal cursorline
        autocmd WinLeave,BufLeave * setlocal nocursorline
    augroup END
endif
set background=dark
color bsmith "custom colorscheme
if has("patch-7.3-787") "relative numbers and absolute will both display
    set number "line numbers
    set relativenumber "and relative numbers (current line is exact)
else
    set relativenumber
    augroup numbering_group
        autocmd!
        autocmd InsertEnter * setlocal norelativenumber "don't need in insert
        autocmd InsertEnter * setlocal number
        autocmd InsertLeave * setlocal relativenumber
    augroup END
endif
set showmatch "highlight matching brackets
if has("cmdline_info")
    set showcmd "show hanging command while typing
endif
if has("wildmenu")
    set wildmenu
    set wildmode=longest:full,full
    set wildignore+=*.a,*.o,*~,*.swp,*.tmp,.git,*.pdf
endif

"{{{-statusline-----------------------------------------------------------------
"much of this taken from: http://stackoverflow.com/a/9121083

augroup statusline_color
    autocmd!
    autocmd InsertEnter * call ColorStatusline('i' . v:insertmode)
    autocmd InsertLeave * call ColorStatusline('n')
    autocmd CursorHold * call ColorStatusline(mode())
augroup END

"work around for not having VisualEnter/VisualLeave autocmds
"see: https://stackoverflow.com/a/15565233
nnoremap <silent> v :call ColorStatusline('v')<CR>v
nnoremap <silent> V :call ColorStatusline('V')<CR>V
nnoremap <silent> <C-v> :call ColorStatusline('CTRL-V')<CR><C-v>
vnoremap <silent> <Esc> <Esc>:call ColorStatusline('n')<CR>

"normal mode colors (green)
highlight StatN1 guifg=#000000 guibg=#87ff00 ctermfg=0 ctermbg=118
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
highlight User9 guifg=#ff0000 guibg=#303030 ctermfg=196 ctermbg=236

"start with statusline in normal mode colors
highlight link User1 StatN1
highlight link User2 StatN2
highlight link User3 StatN3

set statusline=%1*
set statusline+=%q "quickfix/location list flag
set statusline+=%w "preview window flag
set statusline+=%h "help file flag
set statusline+=\ %<%f "file name

set statusline+=\ %2*▶%3* "a fancy separator

set statusline+=\ %m "modified flag
set statusline+=%9*%r%3* "read only flag
set statusline+=%{&paste>0?'[paste]':''} "paste mode flag
set statusline+=%{&spell>0?'[spell]':''} "spell mode flag

set statusline+=\ %= "align right

set statusline+=%y "filetype
set statusline+=\ %{&fenc} "file encoding
set statusline+=[%{&ff}] "file format

set statusline+=\ %2*◀%1* "a fancy separator

set statusline+=\ %P "percent through file as ruler displays it
set statusline+=\ L:%5(%l%) "line
set statusline+=\ C:%3(%c%) "column

set laststatus=2 "always show statusline
set showmode
"}}}----------------------------------------------------------------------------

set lazyredraw "don't redraw the screen when executing macros (for speed)
set scrolloff=5 "keep 5 lines visible above or below cursor
set scrolljump=5 "scrolls 5 lines instead of 1
set listchars=tab:▶-,nbsp:␣,trail:∙,eol:↵
if has("patch-7.4-711") "option 'space' was added in this patch
    set listchars+=space:∙
endif

if has("windows") && has("folding")
    set fillchars+=vert:│
    "make splits feel more correct
    set splitbelow "splits open below instead of above
    set splitright "splits open right instead of left
endif

"searching
if has("extra_search")
    set incsearch
    set hlsearch "highlight all matches (:nohlsearch or :noh to stop)
endif
set ignorecase "case insensitive search
set smartcase "unless I searched for capitalized letters
"}}}----------------------------------------------------------------------------


"{{{-text formatting------------------------------------------------------------
set tabstop=4
set autoindent
set shiftwidth=4
set expandtab "use softabs by default (:set noexpandtab)
set softtabstop=4 "softtabs (tab key types spaces)
set textwidth=80 "wrap at 80 columns by default
set formatoptions-=t "turn off auto-formatting of text by default
set nowrap "don't wrap text by default

augroup misc_group
    autocmd!

    "automatically open thw quickfix window after grep commands
    autocmd QuickFixCmdPost *grep* cwindow

    "trim trailing whitespaces before saving
    autocmd BufWritePre * call RemoveTrailingSpaces()

    "open epub files for editing (can use this for zip files too)
    "see: www.albertopettarin.it/blog/2014/06/03/open-epub-files-with-vim.html
    autocmd BufReadCmd *.epub call zip#Browse(expand("<amatch>"))

    "insert header for new markdown files in a 'Notebook' directory
    autocmd BufNewFile **/Notebook/*.md call notebook#NewEntry()
augroup END

if has("folding")
    "enable folding of code blocks
    set foldmethod=syntax
    set foldlevelstart=99 "start with no folds closed
endif
"}}}----------------------------------------------------------------------------


"{{{-template settings----------------------------------------------------------
augroup template_group
    autocmd!

    "autofilled templates
    autocmd BufNewFile Makefile source ~/.vim/custom/templates/Makefile.vim
    autocmd BufNewFile *.c,*.cpp source ~/.vim/custom/templates/c.vim
    autocmd BufNewFile *.h source ~/.vim/custom/templates/h.vim
    autocmd BufNewFile *.java source ~/.vim/custom/templates/java.vim
    autocmd BufNewFile *.js source ~/.vim/custom/templates/javascript.vim
    autocmd BufNewFile *.tex source ~/.vim/custom/templates/tex.vim
    autocmd BufNewFile *.html source ~/.vim/custom/templates/html.vim
    autocmd BufNewFile *.py source ~/.vim/custom/templates/python.vim
augroup END
"}}}----------------------------------------------------------------------------


"{{{-abbreviations--------------------------------------------------------------
"abbreviation for remembering my grep flags
cabbrev grep <C-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'grep -srnw
            \ --binary-files=without-match --exclude-dir=.git
            \ --exclude-dir=node_modules . -e' : 'grep')<CR>


"{{{-ignore accidental capitalizations------------------------------------------
"need commands because abbreviations only get replaced after hitting space/tab
command! WQA wqa
command! WQa wqa
command! Wqa wqa
command! WQ wq
command! Wq wq
command! WA wa
command! Wa wa
command! QA qa
command! Qa qa
command! W w
command! Q q

cabbrev B b
cabbrev E e
"}}}----------------------------------------------------------------------------
"}}}----------------------------------------------------------------------------


"{{{-my functions---------------------------------------------------------------
"useful function for making colorschemes
"see: vim.wikia.com/wiki/Showing_syntax_highlight_group_in_statusline
function! SyntaxItem()
    echo synIDattr(synID(line("."),col("."),1),"name")
endfunction

"function to toggle the background between light and dark
function! ToggleBackground()
    if &background == "dark"
        set background=light
    else
        set background=dark
    endif
endfunction

"function to change the colors of the statusline based on what mode is active
function! ColorStatusline(mode)
    if a:mode == 'ii' || a:mode == 'i'
        "normal insert
        highlight link User1 StatI1
        highlight link User2 StatI2
        highlight link User3 StatI3
    elseif a:mode == 'ir' || a:mode == 'R'
        "insert replace mode
        highlight link User1 StatR1
        highlight link User2 StatR2
        highlight link User3 StatR3
    elseif a:mode == 'iv' || a:mode == 'Rv'
        "virtual insert mode
        highlight link User1 StatI1
        highlight link User2 StatI2
        highlight link User3 StatI3
    elseif a:mode == 'n'
        "normal mode
        highlight link User1 StatN1
        highlight link User2 StatN2
        highlight link User3 StatN3
    elseif a:mode == 'v' || a:mode == 's'
        "visual mode
        highlight link User1 StatV1
        highlight link User2 StatV2
        highlight link User3 StatV3
    elseif a:mode == 'V' || a:mode == 'S'
        "visual line mode
        highlight link User1 StatV1
        highlight link User2 StatV2
        highlight link User3 StatV3
    elseif a:mode == 'CTRL-V' || a:mode == 'CTRL-S'
        "visual block mode
        highlight link User1 StatV1
        highlight link User2 StatV2
        highlight link User3 StatV3
    else
        "use normal colors
        highlight link User1 StatN1
        highlight link User2 StatN2
        highlight link User3 StatN3
    endif
endfunction

"function to easily toggle into a 'hex editor mode' which pipes the buffer
"   through xxd
function! ToggleHexMode()
    if !exists("b:hexMode") || !b:hexMode
        setlocal binary
        setlocal noeol
        execute ":%!xxd"
        let b:hexMode=1
    else
        setlocal nobinary
        setlocal eol
        execute ":%!xxd -r"
        let b:hexMode=0
    endif
endfunction

"function to toggle diff mode for the current buffer
function! ToggleDiffMode()
    if &diff
        execute ":diffoff"
    else
        execute ":diffthis"
    endif
endfunction

"see: vim.wikia.com/wiki/Remove_unwanted_spaces
"+: stackoverflow.com/questions/6496778/vim-run-autocmd-on-all-filetypes-except
function! RemoveTrailingSpaces()
    if !&binary && &filetype != 'diff'
        if !exists('b:keepTrailingSpaces')
            normal mz
            normal Hmy
            %s/\s\+$//e
            normal 'yz<CR>
            normal `z
        endif
    endif
endfunction

"function to reload the vimrc
if !exists("*Reload()")
    function! Reload()
        source $MYVIMRC
        filetype detect
    endfunction
endif
"}}}----------------------------------------------------------------------------


"{{{-my mappings----------------------------------------------------------------
"call the SyntaxItem function
command! HlGroup call SyntaxItem()

"Reload vimrc
command! Reload call Reload()

"Clear the last used search pattern
command! ClearSearch let @/=""

"Toggle editing in Hex mode
command! Hex call ToggleHexMode()

"Toggle diff mode for current buffer
command! Diff call ToggleDiffMode()

"unbind keys
nnoremap <space> <nop>
nnoremap - <nop>
nnoremap + <nop>

augroup cmdwin
    autocmd!

    "enter is usefull in the cmdwin
    autocmd CmdWinEnter * nunmap <CR>
    autocmd CmdWinLeave * nnoremap <CR> :
augroup END

"{{{-leader mappings
let g:mapleader="\<Space>" "set <leader> as space

nnoremap <leader>b :ls<CR>:b<space>
nnoremap <leader>c :chdir %:h<CR>
nnoremap <leader>d :Diff<CR>
nnoremap <leader>e :e<space>
nnoremap <leader>h :nohlsearch<CR>
nnoremap <leader>l :set list!<CR>
"use <leader>m and <leader>M to place and unplace a '>' in the sign column
sign define bsmith_mark linehl=Underlined text=>
nnoremap <leader>m :exe ":sign place 1 name=bsmith_mark line=" . line('.') . " file=" . expand('%:p')<CR>
nnoremap <leader>M :exe ":sign unplace * file=" . expand('%:p')<CR>
nnoremap <leader>q :q<CR>
"substitute word under cursor
nnoremap <leader>s :%s/\<<C-r><C-w>\>/
nnoremap <leader>v :e $MYVIMRC<CR>

if &diff "vimdiff leader mappings
    "next difference
    nnoremap <leader>n ]c
    "previous difference
    nnoremap <leader>N [c
endif
"}}}

"enter in Normal is a shortcut to Command
nnoremap <CR> :

"backspace in Normal clears search pattern
nnoremap <BS> :ClearSearch<CR>

"center screen when jumping to next/previous matches
"credit: blog.sanctum.geek.nz/vim-annoyances
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

"make Y behave like C and D
noremap Y y$

"make Q execute and insert a shell command on the current line
noremap Q !!$SHELL<CR>

"make K use built-in Man command
nnoremap K :execute ":Man " . expand("<cword>")<CR>

"use <Ctrl + w then Tab> and <Ctrl + w then Shift + Tab> to cycle between splits
nnoremap <c-w><Tab> <c-w>w
nnoremap <c-w><s-Tab> <c-w>W

"[F1] toggles the background light/dark
noremap <F1> :call ToggleBackground()<CR>
inoremap <F1> <C-o>:call ToggleBackground()<CR>


"[F2] toggles file explorer
noremap <F2> :Lexplore<CR>

"[F3] greps current project directory for word under cursor (results in buffer)
noremap <F3> :execute "grep -srnw --binary-files=without-match
    \ --exclude-dir=.git --exclude-dir=node_modules . -e " . expand("<cword>")
    \ <CR><CR><CR>

"[F5] saves
noremap <F5> :w<CR>
inoremap <F5> <C-o>:w<CR>

"[F7] toggles paste mode
noremap <F7> :setlocal paste!<CR>
inoremap <F7> <C-o>:setlocal paste!<CR>
set pastetoggle=<F7>

"[F8] toggles spellcheck
noremap <F8> :setlocal spell!<CR>
inoremap <F8> <C-o>:setlocal spell!<CR>

"[F9] opens suggestions for next misspelled word
noremap <F9> ]sz=
inoremap <F9> <C-o>]sz=
"}}}----------------------------------------------------------------------------


"{{{-other files----------------------------------------------------------------
" use ~/.vimrc.local for machine local changes
if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif
"}}}----------------------------------------------------------------------------
