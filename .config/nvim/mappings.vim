""""""""""""
" Mappings "
""""""""""""

nnoremap <S-J> :bnext<CR>
nnoremap <S-K> :bprev<CR>
nnoremap <C-P> :GFiles<CR>
nnoremap <C-S> :PRg<CR>
nnoremap <C-B> :Buffers<CR>

nnoremap <silent>K :Lspsaga hover_doc<CR>


"" Trouble mappings
nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>
