" Bradford Smith
" ~/.vimrc
" updated: 2021-02-11
"""""""""""""""""""""

"{{{-core stuff-----------------------------------------------------------------
set encoding=utf-8 "use UTF-8 internally
scriptencoding utf-8 "this file uses UTF-8
set backspace=indent,eol,start
set noerrorbells
set visualbell
set t_vb=
set tags+=tags;,./tags;
if has('viminfo')
    set viminfo+=n~/.vim/viminfo
endif
set nomodeline
set notimeout "don't timeout on :mappings
set ttimeout "timeout on key codes (like esc and arrow keys)
set ttimeoutlen=50 "esc and arrows timeout
set mouse=nr "normal and 'Hit Enter' messages
filetype plugin indent on
"}}}----------------------------------------------------------------------------


"{{{-plugins--------------------------------------------------------------------
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
Plug 'AndrewRadev/linediff.vim'
Plug 'airblade/vim-rooter'
Plug 'artoj/qmake-syntax-vim'
Plug 'baskerville/vim-sxhkdrc'
Plug 'bradford-smith94/vim-autolist'
Plug 'bradford-smith94/vim-colors-bsmith'
Plug 'bradford-smith94/vim-dauber'
Plug 'bradford-smith94/vim-superupdate'
Plug 'chrisbra/Colorizer', { 'for': ['css', 'scss', 'html', 'xdefaults'] }
if ! has('patch-8.1-360')
    Plug 'chrisbra/vim-diff-enhanced'
endif
Plug 'editorconfig/editorconfig-vim'
Plug 'EinfachToll/DidYouMean'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'honza/vim-snippets'
Plug 'konfekt/fastfold'
Plug 'markonm/traces.vim'
Plug 'matze/vim-tex-fold'
Plug 'mgrabovsky/vim-xverif'
Plug 'mtth/scratch.vim'
Plug 'mxw/vim-jsx'
Plug 'nelstrom/vim-markdown-folding'
Plug 'nikvdp/ejs-syntax'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'pangloss/vim-javascript'
Plug 'runoshun/vim-alloy'
if ! has('patch-8.2-1066') && has('patch-7.3-885') && has('lua')
    Plug 'shougo/neocomplete'
else
    Plug 'ervandew/supertab'
endif
if v:version >= 704 && (has('python3') || has('python'))
    Plug 'SirVer/ultisnips'
endif
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'unblevable/quick-scope'
Plug 'vim-scripts/scons.vim'
"originally scrooloose/syntastic
Plug 'vim-syntastic/syntastic'
Plug 'Yggdroot/indentLine', { 'for': [ 'python', 'html', 'xhtml', 'xml', 'yaml' ] }
call plug#end()

"felt like these belonged with plugin initialization
source $VIMRUNTIME/ftplugin/man.vim "initializes the :Man command
set keywordprg=:Man
runtime macros/matchit.vim "sources extended mappings for '%'

"{{{-plugin settings------------------------------------------------------------
let g:netrw_banner = 0
let g:netrw_winsize = -30

let g:syntastic_mode_map = {
            \ 'mode': 'active',
            \ 'active_filetypes': [],
            \ 'passive_filetypes': ['ejs', 'html'] }

if ! has('patch-8.2-1066') && has('patch-7.3-885') && has('lua')
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#enable_auto_close_preview = 1
    inoremap <expr><BS> neocomplete#smart_close_popup() ."\<C-h>"
endif

"only do quick-scope highlighting after pressing f, F, t and T keys
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
augroup plugin_highlights
    autocmd!
    autocmd ColorScheme * highlight QuickScopePrimary guifg=#5fd7ff gui=underline ctermfg=81 cterm=underline
    autocmd ColorScheme * highlight QuickScopeSecondary guifg=#d7005f gui=underline ctermfg=161 cterm=underline
    autocmd ColorScheme * call dauber#config#SetColors()
augroup END

if has('python') || has('python3')
    let g:UltiSnipsExpandTrigger = '<Tab>'
    "let g:UltiSnipsListSnippets = "<C-Tab>"
    let g:UltiSnipsJumpForwardTrigger = '<Tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
endif

let g:superupdate_skip_first = 1

let g:indentLine_fileType = ['python', 'html', 'xhtml', 'xml', 'yaml']
let g:indentLine_setColors = 0

let g:colorizer_auto_filetype = 'css,scss,xdefaults'

let g:tex_fold_additional_envs = ['itemize', 'tabular', 'verbatim']

"enable jsx in *.js files
let g:jsx_ext_required = 0

let g:scratch_top = 0

let g:rooter_manual_only = 1

"when started in diffmode set diff algorithm to patience (EnhancedDiff plugin)
if &diff && ! has('patch-8.1-360')
    let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
elseif &diff
    set diffopt+=internal,algorithm:patience
endif

"for opening man pages from the shell
if !empty($MAN_PN)
    augroup man_page_group
        autocmd!
        autocmd StdinReadPost * call manpage#SaveStdinManpage()
    augroup END
endif
"}}}----------------------------------------------------------------------------
"}}}----------------------------------------------------------------------------


"{{{-visual stuff---------------------------------------------------------------
if has('syntax')
    if !exists('g:syntax_on')
        syntax enable
    endif
    set cursorline
    augroup cursorline_group
        autocmd!
        autocmd WinEnter,BufEnter * setlocal cursorline
        autocmd WinLeave,BufLeave * setlocal nocursorline
    augroup END
endif
if filereadable('/proc/version') "fix WSL cursor issues
    let lines = readfile('/proc/version')
    if lines[0] =~# 'Microsoft'
        let &t_SI.="\e[1 q" "SI = Insert mode
        let &t_SR.="\e[1 q" "SR = Replace mode
        let &t_EI.="\e[1 q" "EI = Normal mode (else)
    endif
endif
set background=dark
colorscheme bsmith
set title "allow Vim to set the window title
set t_ut= "fixes issues with background color erase (BCE)
set number
set relativenumber

if has('wildmenu')
    set wildmenu
    set wildmode=longest:full,full
    set wildignorecase
    set wildignore+=*.a,*.o,*.pyc,*.class
    set wildignore+=*~,*.swp,*.tmp,*.bak
    set wildignore+=.git,tags
    set wildignore+=*/node_modules/*
    set wildignore+=*/__pycache__/*
    set wildignore+=*.jpg,*.png,*.pdf
endif

"{{{-statusline-----------------------------------------------------------------
augroup statusline_switcher
    autocmd!
    autocmd VimEnter * call <SID>SetFancyStatusline()
    autocmd BufWinEnter,WinEnter * call <SID>SetFancyStatusline()
    autocmd WinLeave * call <SID>SetSimpleStatusline()
augroup END

set laststatus=2 "always show statusline
set showmode
set showmatch "highlight matching brackets
if has('cmdline_info')
    set showcmd
endif

"{{{-statusline functions
"function to set a "fancy" powerline/*line-like statusline
function! s:SetFancyStatusline()
    setlocal statusline=%1*
    setlocal statusline+=%q "quickfix/location list flag
    setlocal statusline+=%w "preview window flag
    setlocal statusline+=%h "help file flag
    setlocal statusline+=\ %<%f\ %3* "file name

    setlocal statusline+=\ %m "modified flag
    setlocal statusline+=%9*%r%3* "read only flag
    setlocal statusline+=%{&paste>0?'[paste]':''} "paste mode flag
    setlocal statusline+=%{&spell>0?'[spell]':''} "spell mode flag

    setlocal statusline+=\ %= "align right

    setlocal statusline+=%y "filetype
    setlocal statusline+=\ %{&fenc} "file encoding
    setlocal statusline+=[%{&ff}]\ %1* "file format

    setlocal statusline+=\ %P "percent through file as ruler displays it
    setlocal statusline+=\ L:%5(%l%) "line
    setlocal statusline+=\ C:%3(%c%) "column
endfunction

"function to set a simplified statusline to be used for inactive windows
function! s:SetSimpleStatusline()
    setlocal statusline=%q "quickfix/location list flag
    setlocal statusline+=%w "preview window flag
    setlocal statusline+=%h "help file flag
    setlocal statusline+=\ %<%f "file name
    setlocal statusline+=\ %m "modified flag
endfunction
"}}}
"}}}----------------------------------------------------------------------------

set lazyredraw "don't redraw the screen when executing macros (for speed)
set scrolloff=5
set scrolljump=5
"list chars unicode: tab U+25b6, nbsp U+2423, trail/space U+2219, eol U+21b5
set listchars=tab:▶-,nbsp:␣,trail:∙,eol:↵
if has('patch-7.4-711') "listchars option 'space' was added in this patch
    set listchars+=space:∙ "U+2219
endif

if has('folding')
    if has('windows')
        set fillchars+=vert:│ "U+2502
        set splitbelow
        set splitright
    endif

    "enable folding by syntax by default
    set foldmethod=syntax
    set foldlevelstart=99 "start with no folds closed
endif

"searching
if has('extra_search')
    set incsearch
    set hlsearch "highlight all matches (:nohlsearch to stop)
endif
set ignorecase
set smartcase
"}}}----------------------------------------------------------------------------


"{{{-text formatting------------------------------------------------------------
set autoindent "use indent from previous line
set shiftwidth=4 "number of spaces for each indent level
set expandtab "tab key types spaces
set softtabstop=4 "number of spaces the tab key types
set textwidth=80
set nowrap

if v:version > 703 || (v:version == 703 && has('patch541'))
    "enable joining of comment lines and removing comment char
    set formatoptions+=j
endif

set nospell
set spelllang=en_us
set spellfile=~/.vim/spell/custom.utf-8.add
augroup spelling
    autocmd!
    autocmd User CustomLazyLoad call spelling#BuildSpellfileIfNeeded()
augroup END

augroup formatting
    autocmd!
    autocmd BufWritePre * call formatting#RemoveTrailingSpaces()
    autocmd BufNewFile **/Notebook/*.md call notebook#NewEntry()
augroup END

"{{{-template settings----------------------------------------------------------
augroup templates
    autocmd!
    autocmd BufNewFile Makefile source ~/.vim/custom/templates/Makefile.vim
    autocmd BufNewFile *.c,*.cpp source ~/.vim/custom/templates/c.vim
    autocmd BufNewFile *.h,*.hpp source ~/.vim/custom/templates/h.vim
    autocmd BufNewFile *.java source ~/.vim/custom/templates/java.vim
    autocmd BufNewFile *.js source ~/.vim/custom/templates/javascript.vim
    autocmd BufNewFile *.tex source ~/.vim/custom/templates/tex.vim
    autocmd BufNewFile *.html source ~/.vim/custom/templates/html.vim
    autocmd BufNewFile *.py source ~/.vim/custom/templates/python.vim
    autocmd BufNewFile .editorconfig source ~/.vim/custom/templates/editorconfig.vim
augroup END
"}}}----------------------------------------------------------------------------
"}}}----------------------------------------------------------------------------


"{{{-misc-autocmds--------------------------------------------------------------
augroup misc
    autocmd!

    autocmd QuickFixCmdPost *grep* cwindow

    "open epub files for editing (can use this for zip files too)
    "see: www.albertopettarin.it/blog/2014/06/03/open-epub-files-with-vim.html
    autocmd BufReadCmd *.epub call zip#Browse(expand("<amatch>"))
augroup END

"setup a simple lazy load that won't trigger until one of the cursorhold
"autocmds fires
"see: wincent's screencast https://www.youtube.com/watch?v=wQ9uB8I0cCg
augroup setup_custom_lazy_load
    autocmd!
    if has('vim_starting')
        autocmd CursorHold,CursorHoldI * call lazy#trigger()
    endif
augroup END
"}}}----------------------------------------------------------------------------


"{{{-abbreviations--------------------------------------------------------------
"abbreviation for remembering my grep flags
cabbrev grep <C-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'grep -srnw
            \ --binary-files=without-match --exclude-dir=.git
            \ --exclude-dir=node_modules --exclude=tags '.
            \ (FindRootDirectory()=='' ? '.' : FindRootDirectory()) .' -e' :
            \ 'grep')<CR>

"make helpclose like cclose and lclose
cabbrev hclose helpclose

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


"{{{-my mappings----------------------------------------------------------------
"commands for debugging syntax highlighting
command! HlGroup call syntax#ShowHighlightGroup()
command! HlTrace call syntax#ShowHighlightLink()

"Reload vimrc
command! Reload call reload#Now()

"Clear the last used search pattern
command! ClearSearch let @/=""

command! Hex call toggle#HexMode()
command! Diff call toggle#DiffMode()

"git helper commands to replace fugitive for my uses
command! Gblame call git#blame()
command! Glog call git#log()

if executable('xclip')
    "copy the given range (or the current line) using xclip
    command! -range Xclip <line1>,<line2>write !xclip -i -selection clipboard
endif

"{{{-leader mappings
"unbind space so it doesn't do anything but be my leader key
nnoremap <space> <nop>
let g:mapleader="\<Space>"

nnoremap <leader><leader> :
nnoremap <leader>b :ls<CR>:b<space>
nnoremap <leader>c :chdir %:h<CR>
nnoremap <leader>d :Diff<CR>
nnoremap <leader>e :e<space>
nnoremap <leader>f :exe ":e " . resolve(join([$HOME, "/.vim/ftplugin/", &filetype, ".vim"], ""))<CR>
nnoremap <leader>h :nohlsearch<CR>
nnoremap <leader>i :IndentLinesToggle<CR>
nnoremap <leader>l :setlocal list!<CR>
nnoremap <leader>m :update<CR>:make<CR>
nnoremap <leader>q :q<CR>
"substitute word under cursor
nnoremap <leader>s :%s/\(\<<C-r><C-w>\>\)/
nnoremap <leader>t :SyntasticCheck<CR>
"use <leader>u and <leader>U to place and unplace a '>' in the sign column
sign define bsmith_mark linehl=Underlined text=>
nnoremap <leader>u :exe ":sign place 1 name=bsmith_mark line=" . line('.') . " file=" . expand('%:p')<CR>
nnoremap <leader>U :exe ":sign unplace * file=" . expand('%:p')<CR>
nnoremap <leader>v :e $MYVIMRC<CR>
nnoremap <leader>w :update<CR>

if &diff "vimdiff leader mappings
    "next difference
    nnoremap <leader>n ]c
    "previous difference
    nnoremap <leader>N [c
endif
"}}}

nnoremap <BS> :ClearSearch<CR>

"double slash in visual searches for selection
"see: http://vim.wikia.com/wiki/Search_for_visually_selected_text
xnoremap // y/<C-r>"<CR>

"center screen when jumping to next/previous matches
"credit: blog.sanctum.geek.nz/vim-annoyances
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
nnoremap gn gnzz
nnoremap gN gNzz

"stay in visual mode while changing indents
xnoremap > >gv
xnoremap < <gv

"make Y behave like C and D
nnoremap Y y$

"make Q execute and insert a shell command on the current line
nnoremap Q "zyy"zp!!$SHELL<CR>

"use <Ctrl + w then Tab> and <Ctrl + w then Shift + Tab> to cycle between splits
nnoremap <c-w><Tab> <c-w>w
nnoremap <c-w><s-Tab> <c-w>W

"[F1] toggles the background light/dark
nnoremap <F1> :call toggle#Background()<CR>
inoremap <F1> <C-o>:call toggle#Background()<CR>


"[F2] toggles file explorer
nnoremap <F2> :Lexplore<CR>

"[F5] saves
nnoremap <F5> :update<CR>
inoremap <F5> <C-o>:update<CR>

"[F7] uses unimpaired to turn on paste mode (leaving insert turns it off)
nmap <F7> <Plug>unimpairedPaste
imap <F7> <C-o><Plug>unimpairedPaste

"[F8] toggles spellcheck
nnoremap <F8> :setlocal spell!<CR>
inoremap <F8> <C-o>:setlocal spell!<CR>

"[F9] opens suggestions for next misspelled word
nnoremap <F9> ]sz=
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
if filereadable(glob('~/.vimrc.local'))
    source ~/.vimrc.local
endif
"}}}----------------------------------------------------------------------------
