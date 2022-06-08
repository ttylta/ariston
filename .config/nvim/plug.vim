"""""""""""
" Plugins "
"""""""""""

call plug#begin()

" Colors
Plug 'dylanaraps/wal.vim'

" Cosmetics
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'airblade/vim-gitgutter'

" Linting
Plug 'dense-analysis/ale'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'ray-x/lsp_signature.nvim'
Plug 'neovim/nvim-lsp'
Plug 'glepnir/lspsaga.nvim'

" Autocomplete
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Optional
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" File browser
Plug 'lambdalisue/fern.vim'
" Plug 'lambdalisue/fern-git-status.vim'
Plug 'tpope/vim-vinegar'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Treestitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" For vsnip user.

" Git
Plug 'tpope/vim-fugitive'


" Language specific
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'evanleck/vim-svelte', {'branch': 'main'}
Plug 'simrat39/rust-tools.nvim'

call plug#end()
