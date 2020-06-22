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

" font
set guifont=FuraCode\ Nerd\ Font\ Mono:h17

" neovide
let g:neovide_cursor_vfx_mode = "railgun"

" enable true colors support
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

" turn off visual bell - fixes issues with scrolling
set novisualbell

" set utf-8 as default encoding
set encoding=utf-8

" enable syntax highlighting
syntax on

" Fix resizing issue
set guioptions+=k

" Relative line numbers
set relativenumber

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

" ctrl-s for save
nnoremap <silent><c-s> :<c-u>update<cr>
vnoremap <silent><c-s> <c-c>:update<cr>gv
inoremap <silent><c-s> <c-o>:update<cr>

" double escape to clear highlight on searched things
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>

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

" Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Search / Grep
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Syntax
Plug 'tikhomirov/vim-glsl'
" Plug 'rust-lang/rust.vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'Valloric/MatchTagAlways'

" Theme
" Plug 'drewtempelmeyer/palenight.vim'
Plug 'joshdick/onedark.vim'

" Airline
Plug 'vim-airline/vim-airline'

" VimBeGood (training only)
Plug 'ThePrimeagen/vim-be-good'

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


" Coc / LanguageServer Autocomplete - in separate file
let cocpath = stdpath('config').'\config\coc.vim'
execute ("source ". cocpath)

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
nnoremap <silent> <C-b> :Buffers<cr>
nnoremap <silent> <C-M-h> :History<cr>
" disable preview window
let g:fzf_preview_window = ''

" Theme
" let g:palenight_terminal_italics=1
" colorscheme palenight
set background=dark
let g:onedark_terminal_italics=1
colorscheme onedark

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" -------- Inline pseudo-plugin stuff

" line number cycling: https://www.youtube.com/watch?v=0aEv1Nj0IPg

function! CycleNumbering() abort
  if exists('+relativenumber')
    execute {
          \ '00': 'set relativenumber   | set number',
          \ '01': 'set norelativenumber | set number',
          \ '10': 'set norelativenumber | set nonumber',
          \ '11': 'set norelativenumber | set number' }[&number . &relativenumber]
  else
    " No relative numbering, just toggle numbers on and off.
    set number!<CR>
  endif
endfunction

nnoremap <silent> <Leader>r :call CycleNumbering()<CR>