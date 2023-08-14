" Get wal colors
exec "source " . $HOME . "/.cache/wal/colors-wal.vim"

" Load configs
let g:fl = ['plug.vim',
  \ 'plug_config.vim',
  \ 'general.vim',
  \ 'color.vim',
  \ 'mappings.vim',
  \ 'commands.vim'
  \ ]

let g:root = expand('<sfile>:p:h')
for s:config in g:fl
  execute printf('source %s/%s', g:root, s:config)
endfor

" Load lua configs
lua <<EOF
  require 'config/lsp'
EOF

map <space>e :lua vim.diagnostic.open_float(0, {scope="line"})<CR>          
