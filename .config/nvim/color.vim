""""""""""
" Colors "
""""""""""

syntax enable

colorscheme wal

hi LineNr ctermfg=yellow
hi CursorLineNr ctermfg=cyan cterm=NONE
hi CursorLine   cterm=NONE ctermbg=black ctermfg=NONE
hi TabLineFill cterm=none ctermfg=cyan  ctermbg=none
hi TabLine     cterm=none ctermfg=cyan ctermbg=none
hi TabLineSel  cterm=none ctermfg=black ctermbg=cyan
hi IndentBlanklineChar cterm=none ctermbg=none ctermfg=3
hi VertSplit	cterm=NONE ctermbg=NONE ctermfg=NONE
hi Conceal cterm=bold ctermfg=cyan

autocmd ColorScheme * highlight VertSplit cterm=NONE ctermfg=NONE ctermbg=NONE
