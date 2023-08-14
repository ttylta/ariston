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
Plug 'williamboman/mason.nvim'

" Autocomplete
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'

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

" Trouble
Plug 'nvim-tree/nvim-web-devicons'
Plug 'folke/trouble.nvim'
Plug 'folke/lsp-colors.nvim'


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
