call plug#begin(stdpath('data') . '/vim-plug')

Plug 'arcticicestudio/nord-vim'
Plug 'vim-airline/vim-airline'
Plug 'machakann/vim-highlightedyank'
	let g:highlightedyank_highlight_duration = 400
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'mfussenegger/nvim-jdtls'

Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'

Plug 'airblade/vim-gitgutter'
Plug 'psliwka/vim-smoothie'
" Plug 'prettier/vim-prettier', { 'do': 'npm install' }

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install'  }
    let g:mkdp_markdown_css = expand('~/setup/markdown.css')

Plug 'sbdchd/neoformat'
Plug 'vim-scripts/winresizer.vim'
    let g:winresizer_start_key = '<leader>wr'

Plug 'jiangmiao/auto-pairs'
    let g:completion_confirm_key = ""
    inoremap <expr> <cr> pumvisible() ? "\<Plug>(completion_confirm_completion)" : "\<cr>"

" Plug 'kyazdani42/nvim-web-devicons'
" Plug 'kyazdani42/nvim-tree.lua'

Plug 'SirVer/ultisnips'
"    let g:UltiSnipsExpandTrigger="<tab>"
"    let g:UltiSnipsJumpForwardTrigger="<tab>"
"    let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
"    use tab to autocomplete

Plug 'honza/vim-snippets'
    let g:completion_enable_snippet = 'UltiSnips'

" Plug 'ObserverOfTime/discord.nvim', {'do': ':UpdateRemotePlugins'}
"    autocmd VimEnter * DiscordUpdatePresence

Plug 'andweeb/presence.nvim'

call plug#end()

colorscheme nord
set termguicolors

let g:diagnostic_virtual_text_prefix = ''
let g:diagnostic_enable_virtual_text = 1

autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
set updatetime=300

let mapleader = ' '
set tabstop=4 shiftwidth=4 expandtab

set clipboard=unnamedplus
set mouse=a
set number
set nocursorline
set scrolloff=2
set sidescrolloff=5
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
set notimeout
set smarttab
set ignorecase
set smartcase

augroup dynamic_smartcase
  autocmd!
  autocmd CmdLineEnter : set nosmartcase
  autocmd CmdLineLeave : set smartcase
augroup END

set noshowmode
set showmatch
augroup dynamic_smartcase
  autocmd!
  autocmd CmdLineEnter : set nosmartcase
  autocmd CmdLineLeave : set smartcase
augroup END

command! FixWhitespace :%s/\s\+$//e
au BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif
noremap <leader>hs :<C-u>split<CR>
noremap <leader>vs :<C-u>vsplit<CR>
set splitbelow
set splitright

noremap <leader>z :bp<CR>
noremap <leader>q :bp<CR>
noremap <leader>x :bn<CR>
noremap <leader>w :bn<CR>
noremap <leader>c :bd<CR>

noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

imap jk <esc>
imap kj <esc>
nmap <leader>ya :%y+<cr>
nmap <C-S> :w<cr>
vmap <C-S> <esc>:w<cr>
imap <C-S> <esc>:w<cr>

nmap <leader>f :Neoformat<cr>

" Tree settings
nnoremap <leader>tt :NERDTreeToggle<CR>
nnoremap <leader>tf :NERDTreeFind<CR>

:lua << EOF
  vim.api.nvim_exec([[
    augroup Terminal
      autocmd!
      au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
      au TermOpen * set nonu
    augroup end
  ]], false)
EOF

" -------------------- LSP ---------------------------------
set completeopt=menuone,noinsert
:lua << EOF
  local nvim_lsp = require('lspconfig')

  local on_attach = function(client, bufnr)
    require('completion').on_attach()

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    end

    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
        :hi LspReferenceRead cterm=bold ctermbg=red guibg=RoyalBlue4
        :hi LspReferenceText cterm=bold ctermbg=red guibg=RoyalBlue4
        :hi LspReferenceWrite cterm=bold ctermbg=red guibg=RoyalBlue4
        augroup lsp_document_highlight
            autocmd!
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
        ]], false)
    end
  end

  local servers = {'pyright', 'clangd', 'tsserver'}
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
    }
  end
  nvim_lsp['jdtls'].setup {
    cmd = {'java-lsp.sh'},
    on_attach=on_attach
  }
EOF

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true
  },
}
EOF

" Completion
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" -------------------- LSP ---------------------------------
