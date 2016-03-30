" Bradford Smith
" .vimrc
" updated: 03/30/2016
"""""""""""""""""""""

"{{{-core stuff-----------------------------------------------------------------
set nocompatible "do not use vi compatible mode, we're better than that
set encoding=utf-8 "use UTF-8 internally
set helplang=en
set nospell "spelling off by default
set spelllang=en_us
set spellfile=~/.vim/spell/custom.utf-8.add
silent! mkspell! ~/.vim/spell/custom.utf-8.add
set backspace=indent,eol,start "makes backspace work like expected
set noerrorbells
set visualbell
set t_vb=
set viminfo='100,<50,s10,h,!,n~/.vim/viminfo "see :help 'viminfo'
set nomodeline "disable modelines
set ttyfast "legacy setting to speed up output, probably useless
set notimeout "don't timeout on :mappings
set ttimeout "timeout on key codes (like esc and arrow keys)
set timeoutlen=50 "esc and arrows timeout
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
        \ https://github.com/gmarik/Vundle.vim $HOME/.vim/bundle/Vundle.vim
    let has_vundle=0
endif

"initialize vundle
filetype off
set rtp+=$HOME/.vim/bundle/Vundle.vim

call vundle#begin()
"plugins '<github_user>/<repo>' or full git path
Plugin 'gmarik/Vundle.vim'
Plugin 'bradford-smith94/vim-colors-bsmith' "repo for my colorscheme
Plugin 'bradford-smith94/vim-superupdate' "automatic plugin updating
Plugin 'bradford-smith94/vim-autolist' "automatic list continuation
Plugin 'ctrlpvim/ctrlp.vim' "kien/ctrlp.vim is unmaintained
Plugin 'tacahiroy/ctrlp-funky' "adds function searching to CtrlP (:CtrlPFunky)
Plugin 'vim-airline/vim-airline' "bling/vim-airline is unmaintained
Plugin 'scrooloose/syntastic'
Plugin 'octol/vim-cpp-enhanced-highlight'
if has("patch-7.3-885") && has("lua") "neocomplete requires v7.3.885 and +lua
    Plugin 'shougo/neocomplete'
endif
Plugin 'tpope/vim-surround' "surroundings motion
Plugin 'tpope/vim-repeat' "allow repeating of surround
Plugin 'unblevable/quick-scope' "highlight unique targets for (f, F, etc)
Plugin 'konfekt/fastfold'
call vundle#end()

"felt like these belonged with plugin initialization
source $VIMRUNTIME/ftplugin/man.vim "initializes the :Man command
runtime macros/matchit.vim "souces extended mappings for '%'

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

let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'

let g:ctrlp_show_hidden = 0

let g:syntastic_javascript_checkers = ["eslint"]
let g:syntastic_html_checkers = ["validator"]

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

"use Tab for completion
inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
if has("patch-7.3-885") && has("lua") "neocomplete requires v7.3.885 and +lua
    "Backspace closes popup
    inoremap <expr><BS> neocomplete#smart_close_popup() ."\<C-h>"
endif
"}}}----------------------------------------------------------------------------


"{{{-visual stuff---------------------------------------------------------------
syntax on
set background=dark
"let &t_Co=256 "force full 256 color support (should auto detect)
color bsmith "custom colorscheme
set number "line numbers
set relativenumber "and relative numbers (current line is exact)
augroup numbering_group
    "clear this autocmd group to protect from re-sourcing this file
    autocmd!
    autocmd InsertEnter * setlocal norelativenumber "don't need relatives in insert
    autocmd InsertEnter * setlocal number "turn numbers back on (supports old versions)
    autocmd InsertLeave * setlocal relativenumber "back on for everything else
augroup END
set cursorline "highlight the line the cursor is on
augroup cursorline_group
    "clear this autocmd group to protect from re-sourcing this file
    autocmd!
    autocmd WinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END
set showmatch "highlight matching brackets
set ruler
set showcmd "show hanging command while typing
set wildmenu
set wildmode=longest:full,full
set wildignore+=*.a,*.o,*~,*.swp,*.tmp,.git "ignore binaries, swaps and git
set laststatus=2 "always show statusline (for airline)
set noshowmode "airline does this better
set lazyredraw "don't redraw the screen when executing macros (for speed)
set scrolloff=5 "keep 5 lines visible above or below cursor
set scrolljump=5 "scrolls 5 lines instead of 1
set fillchars+=vert:│
set listchars=tab:▶-,nbsp:␣,trail:∙,eol:↵
if has("patch-7.4-711") "option 'space' was added in this patch
    set listchars+=space:∙
endif

"make splits feel more correct
set splitbelow "splits open below instead of above
set splitright "splits open right instead of left

"searching
set incsearch
set ignorecase "case insensitive search
set smartcase "unless I searched for capitalized letters
set hlsearch "highlight all matches (:nohlsearch or :noh to stop)
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
    "clear this autocmd group to protect from re-sourcing this file
    autocmd!

    "trim trailing whitespaces before saving
    autocmd BufWritePre * call RemoveTrailingSpaces()

    "open epub files for editing (can use this for zip files too)
    "see: www.albertopettarin.it/blog/2014/06/03/open-epub-files-with-vim.html
    autocmd BufReadCmd *.epub call zip#Browse(expand("<amatch>"))
augroup END

"enable folding of code blocks
set foldmethod=syntax
set nofoldenable "do not start folded
"}}}----------------------------------------------------------------------------


"{{{-template settings----------------------------------------------------------
augroup template_group
    "clear this autocmd group to protect from re-sourcing this file
    autocmd!

    "autofilled templates
    autocmd BufNewFile Makefile source ~/.vim/templates/Makefile.vim
    autocmd BufNewFile *.c,*.cpp source ~/.vim/templates/c.vim
    autocmd BufNewFile *.h source ~/.vim/templates/h.vim
    autocmd BufNewFile *.java source ~/.vim/templates/java.vim
    autocmd BufNewFile *.js source ~/.vim/templates/javascript.vim
    autocmd BufNewFile *.tex source ~/.vim/templates/tex.vim
    autocmd BufNewFile *.html source ~/.vim/templates/html.vim
    autocmd BufNewFile *.py source ~/.vim/templates/python.vim
augroup END
"}}}----------------------------------------------------------------------------


"{{{-ignore accidental capitalizations------------------------------------------
cabbrev WQA wqa
cabbrev WQa wqa
cabbrev Wqa wqa
cabbrev WQ wq
cabbrev Wq wq
cabbrev WA wa
cabbrev Wa wa
cabbrev W w
cabbrev Q q

cabbrev B b
cabbrev E e
"}}}----------------------------------------------------------------------------


"{{{-abbreviations to fix typos-------------------------------------------------
iabbrev teh the
iabbrev ahve have
iabbrev waht what
iabbrev taht that
iabbrev smae same
"}}}-----------------------------------------------------------------------------


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
command! HighlightGroup call SyntaxItem()
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
nnoremap <CR> <nop>
nnoremap - <nop>
nnoremap + <nop>

"{{{-leader mappings
let g:mapleader="\<Space>" "set <leader> as space

nnoremap <leader>o :CtrlP<CR>
nnoremap <leader>f :CtrlPFunky<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>v :e $MYVIMRC<CR>
"substitute word under cursor
nnoremap <leader>s :%s/\<<C-r><C-w>\>/
nnoremap <leader>c :chdir %:h<CR>
nnoremap <leader>d :Diff<CR>
nnoremap <leader>l :set list!<CR>

if &diff "vimdiff leader mappings
    "next difference
    nnoremap <leader>n ]c :
    "previous difference
    nnoremap <leader>N [c :
endif
"}}}

"backspace in Normal clears search pattern
nnoremap <bs> :ClearSearch<CR>

"center screen when jumping to next
"credit: blog.sanctum.geek.nz/vim-annoyances
nnoremap n nzz
nnoremap N Nzz

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

"[F2] toggles file explorer
noremap <F2> :Lexplore<CR>

"[F3] greps current project directory for word under cursor (results in buffer)
noremap <F3> :execute " grep -srnw --binary-files=without-match
    \ --exclude-dir=.git . -e " . expand("<cword>") . " "
    \ <bar> cwindow<CR><CR><CR>

"[F5] saves
noremap <F5> :w<CR>
inoremap <F5> <Esc>:w<CR>

"[F8] toggles spellcheck
noremap <F8> :setlocal spell!<CR>
inoremap <F8> <Esc>:setlocal spell!<CR>a

"[F9] opens suggestions for next misspelled word
noremap <F9> ]sz=
inoremap <F9> <Esc>]sz=
"}}}----------------------------------------------------------------------------


"{{{-other files----------------------------------------------------------------
" use ~/.vimrc.local for machine local changes
if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif
"}}}----------------------------------------------------------------------------
