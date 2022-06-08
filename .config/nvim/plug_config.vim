"""""""""""""""
" Plug Config "
"""""""""""""""

" Fern
map <C-n> :Fern . -drawer<CR>
let g:fern#renderer#default#collapsed_symbol = ' • '
let g:fern#renderer#default#expanded_symbol = ' ⌄ '
let g:fern#renderer#default#leaf_symbol = '   '

"" Ale
let g:ale_sign_error = '∙ '
let g:ale_sign_warning = '! '

let g:ale_linters = {
\  'javascript': ['eslint'],
\}

let g:ale_fixers = {
\  'javascript': ['eslint'],
\}

let g:ale_fix_on_save = 1
