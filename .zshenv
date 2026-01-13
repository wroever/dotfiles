export CLICOLOR=YES
export LSCOLORS=dxgxcxdxcxegedabagacad

if type dircolors >/dev/null; then
  eval $(dircolors -b ~/.dir_colors)
elif type gdircolors >/dev/null; then
  eval $(gdircolors -b ~/.dir_colors)
fi

exports_file=~/.exports
[ -r "$exports_file" ] && [ -f "$exports_file" ] && source "$exports_file";
