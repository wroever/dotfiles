# l10n: Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

# History
export HISTTIMEFORMAT='%F %T '                  # ISO 8601-format hist timestamps
export HISTCONTROL="erasedups:ignoreboth"       # No duplicate entries
export HISTSIZE=10000                           # Big big history (default is 500)
export HISTFILESIZE=$HISTSIZE
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:jobs:history:clear"
type shopt &> /dev/null && shopt -s histappend  # Append to history, don't overwrite it

# Editor
export EDITOR="vim"

# Colors
export GREP_OPTIONS='--color=auto'
if command -v dircolors > /dev/null 2>&1;
then
    # Per github.com/trapd00r/LS_COLORS
    command -v gdircolors >/dev/null 2>&1 || alias gdircolors="dircolors"
    eval "$(gdircolors -b ~/.dircolors)"
else
    export CLICOLOR=YES
    export LSCOLORS='dxgxcxdxcxegedabagacad'
fi

export PS1='[\[\e[91;1m\]\u\[\e[0m\]@\[\e[93m\]\h\[\e[0m\]:\[\e[0m\]\W]$(__git_ps1 "\[\e[90m\](%s)\[\e[0m\]")» \[\e[0m\]'
export GIT_PS1_SHOWDIRTYSTATE="."
export GIT_PS1_STATESEPARATOR=""

# Load the shell dotfiles, and then some:
# * ~/.extras    : private or host-specific initialization
# * ~/.path      : used to extend `$PATH`.
# * ~/.aliases   : aliases for common tasks
# * ~/.functions : utility functions

for file in ~/.{git-completion.bash,git-prompt.sh,extras,path,aliases,functions}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
