" Bradford Smith
" ~/.vimrc
" updated: 09/14/2017
"""""""""""""""""""""

"{{{-core stuff-----------------------------------------------------------------
set encoding=utf-8 "use UTF-8 internally
scriptencoding utf-8
set nospell "spelling off by default
set spelllang=en_us
set spellfile=~/.vim/spell/custom.utf-8.add
silent! mkspell! ~/.vim/spell/custom.utf-8.add
set backspace=indent,eol,start "makes backspace work like expected
set noerrorbells
set visualbell
set t_vb=
set tags+=tags;,./tags;
set viminfo='100,<50,s10,/0,h,n~/.vim/viminfo "see :help 'viminfo'
set nomodeline "disable modelines
set notimeout "don't timeout on :mappings
set ttimeout "timeout on key codes (like esc and arrow keys)
set ttimeoutlen=50 "esc and arrows timeout
set mouse=nr "normal and 'Hit Enter' messages (useful for switching windows)
filetype plugin indent on
"}}}----------------------------------------------------------------------------


"{{{-setup vim-plug to manage plugins-------------------------------------------
"see: https://github.com/junegunn/vim-plug/wiki/faq#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    augroup vimplug_first_install_group
        autocmd!
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    augroup END
endif

call plug#begin('~/.vim/bundle')
"plugins '<github_user>/<repo>' or full git path
Plug 'artoj/qmake-syntax-vim'
Plug 'baskerville/vim-sxhkdrc'
"my fork of 'unblevable/quick-scope'
Plug 'bradford-smith94/quick-scope'
Plug 'bradford-smith94/vim-autolist'
Plug 'bradford-smith94/vim-colors-bsmith'
Plug 'bradford-smith94/vim-dauber'
Plug 'bradford-smith94/vim-superupdate'
Plug 'chrisbra/Colorizer', { 'for': ['css', 'html', 'xdefaults'] }
if executable('editorconfig')
    Plug 'editorconfig/editorconfig-vim'
endif
Plug 'EinfachToll/DidYouMean'
Plug 'honza/vim-snippets'
Plug 'konfekt/fastfold'
Plug 'matze/vim-tex-fold'
Plug 'mgrabovsky/vim-xverif'
Plug 'nelstrom/vim-markdown-folding'
Plug 'nikvdp/ejs-syntax'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'pangloss/vim-javascript'
Plug 'runoshun/vim-alloy'
if has('patch-7.3-885') && has('lua') "neocomplete requires v7.3.885 and +lua
    Plug 'shougo/neocomplete'
endif
if v:version >= 704 && (has('python') || has('python3'))
    Plug 'SirVer/ultisnips'
endif
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'vim-scripts/scons.vim'
"originally scrooloose/syntastic
Plug 'vim-syntastic/syntastic'
Plug 'Yggdroot/indentLine', { 'for': [ 'html', 'xhtml', 'xml' ] }
call plug#end()

"felt like these belonged with plugin initialization
source $VIMRUNTIME/ftplugin/man.vim "initializes the :Man command
runtime macros/matchit.vim "sources extended mappings for '%'
"}}}----------------------------------------------------------------------------


"{{{-plugin settings------------------------------------------------------------
let g:netrw_banner = 0
let g:netrw_winsize = -30

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_html_checkers = ['validator']
let g:syntastic_vim_checkers = ['vint']
let g:syntastic_mode_map = {
            \ 'mode': 'active',
            \ 'active_filetypes': [],
            \ 'passive_filetypes': ['ejs', 'html'] }

if has('patch-7.3-885') && has('lua') "neocomplete requires v7.3.885 and +lua
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#enable_auto_close_preview = 1
endif

"only do quick-scope highlighting after pressing f, F, t and T keys
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
augroup qs_highlights
    autocmd!
    autocmd ColorScheme * highlight QuickScopePrimary gui=underline ctermfg=81 cterm=underline
    autocmd ColorScheme * highlight QuickScopeSecondary gui=underline ctermfg=161 cterm=underline
augroup END

if has('python') || has('python3')
    let g:UltiSnipsExpandTrigger = '<Tab>'
    "let g:UltiSnipsListSnippets = "<C-Tab>"
    let g:UltiSnipsJumpForwardTrigger = '<Tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
endif

if has('patch-7.3-885') && has('lua') "neocomplete requires v7.3.885 and +lua
    "Backspace closes popup
    inoremap <expr><BS> neocomplete#smart_close_popup() ."\<C-h>"
endif

"have superupdate skip first run because of automatic install
let g:superupdate_skip_first = 1

"only enable indentLine for some filetypes
let g:indentLine_fileType = ['html', 'xhtml', 'xml']

let g:colorizer_auto_filetype = 'css,xdefaults'

let g:tex_fold_additional_envs = ['itemize', 'tabular', 'verbatim']

"for opening man pages from the shell
if !empty($MAN_PN)
    augroup man_page_group
        autocmd!
        autocmd StdinReadPost * call manpage#SaveStdinManpage()
    augroup END
endif
"}}}----------------------------------------------------------------------------


"{{{-visual stuff---------------------------------------------------------------
if has('syntax')
    if !exists('g:syntax_on')
        syntax enable
    endif
    set cursorline "highlight the line the cursor is on
    augroup cursorline_group
        autocmd!
        autocmd WinEnter,BufEnter * setlocal cursorline
        autocmd WinLeave,BufLeave * setlocal nocursorline
    augroup END
endif
set background=dark
color bsmith "custom colorscheme
set title "allow Vim to set the window title
set t_ut= "fixes issues with background color erase (BCE)
if has('patch-7.3-787') "relative numbers and absolute will both display
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
if has('cmdline_info')
    set showcmd "show hanging command while typing
endif
if has('wildmenu')
    set wildmenu
    set wildmode=longest:full,full
    set wildignore+=*.a,*.o,*~,*.swp,*.tmp,.git,*.pdf
endif

"{{{-statusline-----------------------------------------------------------------
augroup StatuslineSwitcher
    autocmd!
    autocmd VimEnter * call SetFancyStatusline()
    autocmd BufWinEnter,WinEnter * call SetFancyStatusline()
    autocmd WinLeave * call SetSimpleStatusline()
augroup END

set laststatus=2 "always show statusline
set showmode
"}}}----------------------------------------------------------------------------

set lazyredraw "don't redraw the screen when executing macros (for speed)
set scrolloff=5 "keep 5 lines visible above or below cursor
set scrolljump=5 "scrolls 5 lines instead of 1
set listchars=tab:▶-,nbsp:␣,trail:∙,eol:↵
if has('patch-7.4-711') "option 'space' was added in this patch
    set listchars+=space:∙
endif

if has('windows') && has('folding')
    set fillchars+=vert:│
    "make splits feel more correct
    set splitbelow "splits open below instead of above
    set splitright "splits open right instead of left
endif

"searching
if has('extra_search')
    set incsearch
    set hlsearch "highlight all matches (:nohlsearch or :noh to stop)
endif
set ignorecase "case insensitive search
set smartcase "unless I searched for capitalized letters
"}}}----------------------------------------------------------------------------


"{{{-text formatting------------------------------------------------------------
set autoindent
set shiftwidth=4
set expandtab
set softtabstop=4
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

if has('folding')
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
    autocmd BufNewFile *.h,*.hpp source ~/.vim/custom/templates/h.vim
    autocmd BufNewFile *.java source ~/.vim/custom/templates/java.vim
    autocmd BufNewFile *.js source ~/.vim/custom/templates/javascript.vim
    autocmd BufNewFile *.tex source ~/.vim/custom/templates/tex.vim
    autocmd BufNewFile *.html source ~/.vim/custom/templates/html.vim
    autocmd BufNewFile *.py source ~/.vim/custom/templates/python.vim
    if executable('editorconfig')
        autocmd BufNewFile .editorconfig source ~/.vim/custom/templates/editorconfig.vim
    endif
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

cabbrev B <C-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'b' : 'B')<CR>
cabbrev E <C-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'e' : 'E')<CR>
"}}}----------------------------------------------------------------------------
"}}}----------------------------------------------------------------------------


"{{{-my functions---------------------------------------------------------------

"function to set a "fancy" powerline/*line-like statusline
function! SetFancyStatusline()
    setlocal statusline=%1*
    setlocal statusline+=%q "quickfix/location list flag
    setlocal statusline+=%w "preview window flag
    setlocal statusline+=%h "help file flag
    setlocal statusline+=\ %<%f "file name

    setlocal statusline+=\ %2*▶%3* "a fancy separator

    setlocal statusline+=\ %m "modified flag
    setlocal statusline+=%9*%r%3* "read only flag
    setlocal statusline+=%{&paste>0?'[paste]':''} "paste mode flag
    setlocal statusline+=%{&spell>0?'[spell]':''} "spell mode flag

    setlocal statusline+=\ %= "align right

    setlocal statusline+=%y "filetype
    setlocal statusline+=\ %{&fenc} "file encoding
    setlocal statusline+=[%{&ff}] "file format

    setlocal statusline+=\ %2*◀%1* "a fancy separator

    setlocal statusline+=\ %P "percent through file as ruler displays it
    setlocal statusline+=\ L:%5(%l%) "line
    setlocal statusline+=\ C:%3(%c%) "column
endfunction

"function to set a simplified statusline
function! SetSimpleStatusline()
    setlocal statusline=%q "quickfix/location list flag
    setlocal statusline+=%w "preview window flag
    setlocal statusline+=%h "help file flag
    setlocal statusline+=\ %<%f "file name
    setlocal statusline+=\ %m "modified flag
endfunction

"useful function for making colorschemes
"see: vim.wikia.com/wiki/Showing_syntax_highlight_group_in_statusline
function! SyntaxItem()
    echo synIDattr(synID(line('.'),col('.'),1),'name')
endfunction

"function to toggle the background between light and dark
function! ToggleBackground()
    if &background ==# 'dark'
        set background=light
    else
        set background=dark
    endif
endfunction

"function to easily toggle into a 'hex editor mode' which pipes the buffer
"   through xxd
function! ToggleHexMode()
    if !exists('b:hexMode') || !b:hexMode
        setlocal binary
        setlocal noeol
        execute ':%!xxd'
        let b:hexMode=1
    else
        setlocal nobinary
        setlocal eol
        execute ':%!xxd -r'
        let b:hexMode=0
    endif
endfunction

"function to toggle diff mode for the current buffer
function! ToggleDiffMode()
    if &diff
        execute ':diffoff'
    else
        execute ':diffthis'
    endif
endfunction

"see: vim.wikia.com/wiki/Remove_unwanted_spaces
"+: stackoverflow.com/questions/6496778/vim-run-autocmd-on-all-filetypes-except
function! RemoveTrailingSpaces()
    if !&binary && &filetype !=# 'diff'
        if !exists('b:keepTrailingSpaces')
            normal! mz
            normal! Hmy
            "vint: -ProhibitCommandRelyOnUser
            "vint: -ProhibitCommandWithUnintendedSideEffect
            %s/\s\+$//e
            "vint: +ProhibitCommandWithUnintendedSideEffect
            "vint: +ProhibitCommandRelyOnUser
            normal! 'yz<CR>
            normal! `z
        endif
    endif
endfunction

"function to unmap and restore any enter key mappings (<CR>) when
"   entering/leaving the cmdwin, arg 'enter' specifies whether or not the
"   function has been called when entering the cmdwin
function! CmdWinEnterMapping(enter)
    if has('patch-7.4-1154') "v:true and v:false added in this patch
        let l:entering = v:true
    else
        let l:entering = 1
    endif
    if a:enter == l:entering
        let b:prev_cr_map = maparg('<CR>', 'n')
        nunmap <CR>
    else
        if exists('b:prev_cr_map')
            execute 'nnoremap <CR> ' . b:prev_cr_map
            unlet b:prev_cr_map
        endif
    endif
endfunction

"function to reload the vimrc
if !exists('*Reload()')
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

if executable('xclip')
    "copy the given range (or the current line) using xclip
    command! -range Xclip <line1>,<line2>!tee >(xclip -i -selection clipboard)
endif

"unbind keys
nnoremap <space> <nop>
nnoremap - <nop>
nnoremap + <nop>

augroup cmdwin
    autocmd!

    "enter is usefull in the cmdwin
    if has('patch-7.4-1154') "v:true and v:false added in this patch
        autocmd CmdWinEnter * call CmdWinEnterMapping(v:true)
        autocmd CmdWinLeave * call CmdWinEnterMapping(v:false)
    else
        autocmd CmdWinEnter * call CmdWinEnterMapping(1)
        autocmd CmdWinLeave * call CmdWinEnterMapping(0)
    endif
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
nnoremap <leader>w :w<CR>

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

"[F7] uses unimpaired to turn on paste mode (leaving insert turns it off)
map <F7> <Plug>unimpairedPaste
imap <F7> <C-o><Plug>unimpairedPaste

"[F8] toggles spellcheck
noremap <F8> :setlocal spell!<CR>
inoremap <F8> <C-o>:setlocal spell!<CR>

"[F9] opens suggestions for next misspelled word
noremap <F9> ]sz=
inoremap <F9> <C-o>]sz=

"{{{-custom text-objects
"a line (including leading and trailing whitespace)
xnoremap al 0o$h
onoremap al :normal val<CR>

"inner line
xnoremap il ^og_lh
onoremap il :normal vil<CR>
"}}}
"}}}----------------------------------------------------------------------------


"{{{-other files----------------------------------------------------------------
" use ~/.vimrc.local for machine local changes
if filereadable(glob('~/.vimrc.local'))
    source ~/.vimrc.local
endif
"}}}----------------------------------------------------------------------------
