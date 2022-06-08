"""""""""""
" General "
"""""""""""

" Base config
set nocompatible
set omnifunc=v:lua.vim.lsp.omnifunc
set completeopt=menu,menuone,noselect
au VimLeave * :!clear
filetype plugin on

" Formatting
set nu rnu
set nowrap
set tabstop=2 shiftwidth=2 expandtab
set autoindent
set hidden
set mouse=a "Because I'm only a hacker in name
set fillchars=vert:\ ,eob:\ 

"UI
set laststatus=0
set noruler
set noshowcmd

" Life improvements
set autochdir
set clipboard=unnamedplus
set sj=-45 " Emacs-like scrolling
set cursorline

" Housekeeping
set noswapfile

" TMUX fixes
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
else
    let &t_SI = "\e[5 q"
    let &t_EI = "\e[2 q"
endif

" Better vsplit
set splitbelow                              
set splitright                              
