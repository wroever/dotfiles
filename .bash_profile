# l10n: Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

# History
export HISTTIMEFORMAT='%F %T '                  # ISO 8601-format hist timestamps
export HISTCONTROL="erasedups:ignoreboth"       # No duplicate entries
export HISTSIZE=10000                           # Big big history (default is 500)
export HISTFILESIZE=$HISTSIZE
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:jobs:history:clear"
shopt -s histappend                             # Append to history, don't overwrite it
shopt -s cmdhist                                # Save multi-line commands as one command

# Default editor
export EDITOR="vim"

# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
set -o noclobber

# Make bash check its window size after a process completes
shopt -s checkwinsize

# Colors
export GREP_OPTIONS='--color=auto'
if command -v dircolors > /dev/null 2>&1;
then
    eval "$(dircolors -b ~/.dircolors)"
elif command -v gdircolors > /dev/null 2>&1;
then
    eval "$(gdircolors -b ~/.dircolors)"
else
    export CLICOLOR=YES
    export LSCOLORS='dxgxcxdxcxegedabagacad'
fi
# Less Colors for Man Pages
# Per: https://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
export LESS_TERMCAP_mb=$'\e[01;31m'       # Begin blinking
export LESS_TERMCAP_md=$'\e[01;38;5;74m'  # Begin bold
export LESS_TERMCAP_me=$'\e[0m'           # End mode
export LESS_TERMCAP_se=$'\e[0m'           # End standout-mode
export LESS_TERMCAP_so=$'\e[38;5;246m'    # Begin standout-mode - info box
export LESS_TERMCAP_ue=$'\e[0m'           # End underline
export LESS_TERMCAP_us=$'\e[04;38;5;146m' # Begin underline

# Load the shell dotfiles, and then some:
# * ~/.extras    : private or host-specific initialization
# * ~/.path      : used to extend `$PATH`.
# * ~/.aliases   : aliases for common tasks
# * ~/.functions : utility functions
for file in ~/.{git-completion.bash,git-prompt.sh,extras,path,aliases,functions}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Prompt string
(( BASH_VERSINFO[0] > 3 )) && PROMPT_DIRTRIM=2 # Automatically trim long paths in the prompt (requires Bash 4.x)
export PS1='[\[\e[91;1m\]\u\[\e[0m\]@\[\e[93m\]\h\[\e[0m\]:\[\e[0m\]\w]\[\e[90m\](\j)$(__git_ps1 "( %s)\[\e[0m\]")» \[\e[0m\]'
export GIT_PS1_SHOWDIRTYSTATE="."
export GIT_PS1_SHOWUNTRACKEDFILES="."
export GIT_PS1_STATESEPARATOR=""

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# virtualenvwrapper
export WORKON_HOME=~/.virtualenvs
VIRTUALENVWRAPPER_INIT=/usr/local/bin/virtualenvwrapper.sh
[ -s "$VIRTUALENVWRAPPER_INIT" ] && source $VIRTUALENVWRAPPER_INIT
