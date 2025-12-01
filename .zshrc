# Set fpath to include location of git completion script
fpath[1,0]="~/.zsh";

# Case-insensitive autocompletion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Load autocompletion
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

# Enable autosuggestions, syntax highlighting
for plugin in zsh-autosuggestions zsh-syntax-highlighting; do
  file="$HOMEBREW_PREFIX/share/$plugin/$plugin.zsh"
  [[ -r $file ]] && source "$file"
done
unset plugin;
unset file;

# Ensure key bindings work in tmux:
# https://unix.stackexchange.com/questions/746605/bindkey-commands-run-in-zshrc-seem-ignored-when-in-tmux
bindkey -e

# Use the text that has already been typed as the prefix for history search
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# Kill text before the cursor, like one does in bash
bindkey \^U backward-kill-line

# Jump forward/backward one word
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

# Fix issue where (Neo)vim changes terminal cursor type
fix_cursor() {
   echo -ne '\e[5 q'
}
precmd_functions+=(fix_cursor)

for file in ~/.{aliases,extras,functions}; do
    [[ -r "$file" ]] && source "$file";
done;
unset file;

# Initialize mise if installed
command -v mise &>/dev/null && eval "$(mise activate zsh)"

# Initialize starship if installed
command -v starship &>/dev/null && eval "$(starship init zsh)"

# TODO: Can this be moved to mise?
[[ -r "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
