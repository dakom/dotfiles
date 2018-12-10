" ----------SYSTEM--------------


" Detect OS
if !exists("g:os")
    if has("win64") || has("win32") || has("win16")
        let g:os = "Windows"
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

" change default startup size on windows which was too small
if g:os == "Windows"
  set lines=70 columns=220
endif

" set caps lock to escape on linux - and back when exiting vim
if g:os == "Linux"
    au VimEnter * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
    au VimLeave * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'
endif

" set font
if g:os == "Darwin"
    set guifont=FuraCode\ Nerd\ Font:h13
elseif g:os == "Windows"
    "just use regular Fira Code - shows in gui dropdown too
    set guifont=Fira\ Code:h11
else
    set guifont=FuraCode\ Nerd\ Font\ Retina\ 13
endif

" enable true colors support
set termguicolors

" turn off visual bell - fixes issues with scrolling
set novisualbell

" set utf-8 as default encoding
set encoding=utf-8

" enable syntax highlighting
syntax on

" Fix resizing issue
set guioptions+=k

" Fix some cursor lag issue
set timeoutlen=1000
set ttimeoutlen=0

" Set backup and swap file directory
if g:os == "Windows"
    set backupdir=/temp//
    set directory=/temp//
else
    set backupdir=/tmp//
    set directory=/tmp//
endif

" ----------USABILITY--------------

" Set Space Leader
let mapleader="\<Space>"

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
 
" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
 
" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" tab settings
set shiftwidth=4
set softtabstop=4
set expandtab

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Change shape of cursor for terminal
let &t_EI = "\033[1 q"
let &t_SI = "\033[4 q"

" Always display the status line, even if only one window is displayed
set laststatus=2

" always show line numbers
set number 

" Enable use of the mouse for all modes
set mouse=a

" always enable sign column for new buffers
autocmd BufRead,BufNewFile * setlocal signcolumn=yes
autocmd FileType tagbar,nerdtree setlocal signcolumn=no " except for these files
 
" always show gutter
set signcolumn="yes"

" echodoc needs extra height and we don't need to see the mode
set noshowmode

" wildmenu
set wildmenu
set wildmode=longest:full,full

" Show partial commands in the last line of the screen
set showcmd
 
" Highlight searches (use <C-L> to temporarily turn off highlighting)
set hlsearch

" Open splits in right and bottom instead of left and top 
set splitright
set splitbelow

" Hide work-in-progress buffers when opening new files
:set hidden

" ----------- CORE KEYBINDINGS----------

" split tab (useful for making current split fullscreen - then :wq to go back)
:noremap tt :tab split<CR>

" use control-hjkl to navigate windows
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Jump to line with enter
:nnoremap <CR> G

" use numeric keypad for enter
:nmap <kEnter> <Enter>

" -----PLUGINS------------

" Vim-Plug Start 
if has('nvim')
    call plug#begin('~/.local/share/nvim/plugged')
else
    call plug#begin('~/.vim/plugged')
endif

" Generic helpers
Plug 'chaoren/vim-wordmotion'

" NERDTree 
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } " toggle with F6

" Buffer Management
Plug 'jlanzarotta/bufexplorer'
Plug 'Asheq/close-buffers.vim'

" LanguageServer (diagnostics, completion, etc.)
" Plug 'w0rp/ale'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}

" Search / Grep
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Syntax
Plug 'tikhomirov/vim-glsl'
" Plug 'rust-lang/rust.vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'Valloric/MatchTagAlways'

" Theme
Plug 'drewtempelmeyer/palenight.vim'
Plug 'vim-airline/vim-airline'

" Vim-Plug End 
call plug#end()

" ----- Plugin Config ------------

" File extensions - override whatever madness plugins did
" au BufRead,BufNewFile *.tsx set filetype=typescript
" au BufRead,BufNewFile *.ts set filetype=typescript
" au BufRead,BufNewFile *.jsx set filetype=javascript
" au BufRead,BufNewFile *.js set filetype=javascript

" MatchTagAlways
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \ 'typescript.tsx' : 1,
    \}
" NERDTree 
nmap <F6> :NERDTreeToggle<CR> " don't open at start in directory
let g:NERDTreeHijackNetrw=0
let loaded_netrw = 0 " needed to also prevent netrw from showing

" BufExplorer - explore/next/previous: Alt-F12, F12, Shift-F12.
nnoremap <silent> <M-F12> :BufExplorer<CR>
nnoremap <silent> <F12> :bn<CR>
nnoremap <silent> <S-F12> :bp<CR> 

" ALE / Diagnostics (completion is handled by deoplete/LanguageClient)
" let g:ale_completion_enabled = 1
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_save = 1
" let g:ale_lint_on_enter = 1
" nmap <silent> <Leader>i <Plug>(ale_detail)
" nmap <silent> <Leader>l <Plug>(ale_lint)
" nmap <silent> <Leader>j <Plug>(ale_next_wrap)
" nmap <silent> <Leader>k <Plug>(ale_previous_wrap)
" nmap <silent> <Leader>h <Plug>(ale_hover) 
" nmap <silent> <Leader>d <Plug>(ale_go_to_definition) 
" nmap <silent> <Leader>r <Plug>(ale_find_references) 
" nmap <silent> <Leader>s :call AleSymbolSearch()<CR>
" let g:ale_sign_error = '✘'
" let g:ale_sign_warning = '⚠'

" Coc / LanguageServer Autocomplete
source $HOME/.config/nvim/config/coc.vim

" Search / Grep
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

set grepprg=rg\ --vimgrep
" set ctrl-p similarities to open files
nnoremap <silent> <C-t> :Files <cr>
nnoremap <silent> <C-p> :Files <cr>
" <M-p> for open buffers
nnoremap <silent> <M-p> :Buffers<cr>
" <M-S-p> for MRU
nnoremap <silent> <M-S-p> :History<cr>

" Theme
set background=dark
let g:palenight_terminal_italics=1
colorscheme palenight

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
