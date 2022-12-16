"
"TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

call plug#begin()
Plug 'neovim/nvim-lspconfig'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'sunjon/stylish.nvim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'rhysd/vim-clang-format'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }                                                                                                                                                           
call plug#end()

colorscheme catppuccin " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha                                                                                                       

let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1

" tab size c++
autocmd Filetype cpp setlocal tabstop=2
autocmd Filetype hpp setlocal tabstop=2

set tabstop=4
set shiftwidth=4
set expandtab

let g:neomake_python_enabled_makers = ['pylint']

let g:python3_host_prog = '/usr/bin/python3'

let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k>TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> <c-ö> :TmuxNavigatePrevious<cr>

lua << EOF
local utils = require("lsp")
require'lspconfig'.clangd.setup{}
EOF
