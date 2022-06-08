typeset -U PATH path

path=(
  "$HOME/.local/bin" 
  "$HOME/.npm/bin"
  "$HOME/.node_modules/bin"
  "$HOME/scripts"
  "$path[@]"
)

export npm_config_prefix=~/.node_modules

export PATH
