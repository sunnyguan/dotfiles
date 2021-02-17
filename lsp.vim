
""" START LSP support
:lua << EOF
  require('lspconfig').util.nvim_multiline_command [[
    augroup Terminal
      autocmd!
      au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
      au TermOpen * set nonu
    augroup end
  ]]
EOF

let g:diagnostic_virtual_text_prefix = ''
let g:diagnostic_enable_virtual_text = 1

imap <silent> <c-p> <Plug>(completion_trigger)
" let g:UltiSnipsExpandTrigger = "<tab>"

set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_enable_snippet = 'UltiSnips'
let g:completion_matching_smart_case = 1
let g:completion_trigger_on_delete = 1
let g:completion_confirm_key = ""
inoremap <expr> <cr>    pumvisible() ? "\<Plug>(completion_confirm_completion)" : "\<cr>"
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
set updatetime=300

set shortmess+=c

command! Format execute 'lua vim.lsp.buf.formatting()'
" autocmd BufWritePre *.java undojoin | Format

:lua << EOF
  local nvim_lsp = require('lspconfig')
  local on_attach = function(_, bufnr)
    require('diagnostic').on_attach()
    require('completion').on_attach()
    local opts = { noremap=true, silent=true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xd', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', opts)
  end
  nvim_lsp.tsserver.setup{ on_attach=require'completion'.on_attach }
  nvim_lsp.pyls.setup{ on_attach=require'completion'.on_attach }
  nvim_lsp.clangd.setup{ on_attach=require'completion'.on_attach }
EOF

"   nvim_lsp.jdtls.setup{ on_attach=require'completion'.on_attach, cmd= {"./Users/test/.local/share/vim-lsp-settings/servers/eclipse-jdt-ls/eclipse-jdt-ls"} }

if has('nvim-0.5')
  augroup lsp
    au!
    au FileType java lua require('jdtls').start_or_attach({cmd = {'start-jdtls.sh'}, on_attach=require('completion').on_attach})
  augroup end
endif

:lua << EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    highlight = {
      enable = true,
      disable = { },
    },
    indent = {
      enabled = true
    }
  }
EOF

