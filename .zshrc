# Colors
export CLICOLOR=YES
export LSCOLORS='dxgxcxdxcxegedabagacad'

export EDITOR=vim

# History
HISTSIZE=10000
setopt EXTENDED_HISTORY   # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY # Write to the history file immediately, not when the shell exits.
setopt HIST_REDUCE_BLANKS # Remove superfluous blanks before recording entry.
# setopt HIST_SAVE_NO_DUPS

# Completions for brew-managed tools
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# Git completion
zstyle ':completion:*:*:git:*' script ~/.git-completion.bash
# Set fpath to include location of git completion script
fpath=(~/.zsh $fpath)

# Case-insensitive autocompletion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Load autocompletion
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

# Use the text that has already been typed as the prefix for history search
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# Kill text before the cursor, like one does in bash
bindkey \^U backward-kill-line

# Fix issue where (Neo)vim changes terminal cursor type
fix_cursor() {
   echo -ne '\e[5 q'
}
precmd_functions+=(fix_cursor)

for file in ~/.{aliases,extras}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;
