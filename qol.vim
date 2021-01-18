"" Map leader to ,
let mapleader = ' '

"" Ctrl-s to save
nmap <C-S> :w<cr>
vmap <C-S> <esc>:w<cr>
imap <C-S> <esc>:w<cr>

"" NERDTree Toggle
nmap <leader>nt :NERDTreeToggle<CR>

"" Set tab
set tabstop=4 shiftwidth=4

"" Enable line numbers
set number

"" Highlight the line on which the cursor lives
set nocursorline

" Always show at least one line above/below the cursor.
set scrolloff=2
" Always show at least one line left/right of the cursor.
set sidescrolloff=5

" Highlight matching pairs of brackets. Use the '%' character to jump between them.
set matchpairs+=<:>

" Display different types of white spaces.
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

" Use system clipboard
set clipboard=unnamedplus

" Remove timeout for partially typed commands
set notimeout

" Indentation
set smarttab
set expandtab

" set auto indent
set autoindent

" Mouse support
set mouse=a

"Case insensitive searching
set ignorecase

"Will automatically switch to case sensitive if you use any capitals
set smartcase

" Auto toggle smart case of for ex commands
" Assumes 'set ignorecase smartcase'
augroup dynamic_smartcase
  autocmd!
  autocmd CmdLineEnter : set nosmartcase
  autocmd CmdLineLeave : set smartcase
augroup END

" Highlighted yank (-1 for persistent)
let g:highlightedyank_highlight_duration = 400

" If lightline/airline is enabled, don't show mode under it
set noshowmode

set background=dark
" Syntax enable
" syntax on

" Show matching
set showmatch

" Clear search highlighting with Escape key
nnoremap <silent><esc> :noh<return><esc>

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
  set t_Co=16
endif

set wildmenu

" remove trailing whitespaces
command! FixWhitespace :%s/\s\+$//e

" Restore last cursor position and marks on open
au BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit' 
      \ |   exe "normal! g`\""
      \ | endif

" Quick exit insert mode with jk/kj
inoremap jk <ESC>
inoremap kj <ESC>

"" Split
noremap <leader>hs :<C-u>split<CR>
noremap <leader>vs :<C-u>vsplit<CR>
set splitbelow
set splitright

" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

" if has('macunix')
"   " pbcopy for OSX copy/paste
"   vmap <C-x> :!pbcopy<CR>
"   vmap <C-c> :w !pbcopy<CR><CR>
" endif

"" Buffer nav
noremap <leader>z :bp<CR>
noremap <leader>q :bp<CR>
noremap <leader>x :bn<CR>
noremap <leader>w :bn<CR>

"" Close buffer
noremap <leader>c :bd<CR>

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

"" Yank all to system clipboard
nmap <leader>ya :%y+<CR>
