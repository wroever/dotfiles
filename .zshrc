# Colors
export CLICOLOR=YES
export LSCOLORS='dxgxcxdxcxegedabagacad'

# Load autocompletion
autoload -Uz compinit && compinit
# Case-insensitive autocompletion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Use the text that has already been typed as the prefix for history search
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# Fix issue where (Neo)vim changes terminal cursor type
fix_cursor() {
   echo -ne '\e[5 q'
}
precmd_functions+=(fix_cursor)

for file in ~/.{aliases,extras}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;
