call plug#begin(stdpath('data') . '/vim-plug')

" LSP related plugins
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'mfussenegger/nvim-jdtls'

" Plug 'prabirshrestha/vim-lsp'
" Plug 'mattn/vim-lsp-settings'

Plug 'jiangmiao/auto-pairs'

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'

Plug 'prettier/vim-prettier', { 'do': 'npm install' }
" Plug 'sbdchd/neoformat'

Plug 'machakann/vim-highlightedyank'
    let g:highlightedyank_highlight_duration = 400

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
    autocmd FileType fzf tnoremap <buffer> <Esc> <Esc>

Plug 'simeji/winresizer'
    let g:winresizer_start_key = "<leader>wr"

Plug 'simnalamburt/vim-mundo'
    nnoremap <F5> :MundoToggle<CR>
    set undofile
    set undolevels=10000
    set undodir=~/.vim/undo_tree

Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
    let g:markdown_fold_style = 'nested'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
    let g:airline_theme='lessnoise'

Plug 'airblade/vim-gitgutter'

Plug 'lervag/vimtex'
    let g:tex_flavor='latex'
    let g:vimtex_quickfix_mode=0

Plug 'KeitaNakamura/tex-conceal.vim'
    set conceallevel=1
    let g:tex_conceal='abdmg'
    hi Conceal ctermbg=none

Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

Plug 'rhysd/vim-clang-format'
    let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11"}
    autocmd FileType c,cpp,objc,java nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
    autocmd FileType c,cpp,objc,java vnoremap <buffer><Leader>cf :ClangFormat<CR>
    " autocmd FileType c,cpp,java ClangFormatAutoEnable

call plug#end()

colorscheme lena

source ~/.config/nvim/qol.vim
source ~/.config/nvim/floating_fzf.vim
source ~/.config/nvim/lsp.vim

" Disable folding column
let g:pandoc#folding#fdc=0

" Conceal link urls
let g:pandoc#syntax#conceal#urls = 1

" Toggle Goyo
nmap <silent><leader>gy :Goyo<CR>

" Set ultisnips triggers
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END

source ~/.config/nvim/pandoc.vim
