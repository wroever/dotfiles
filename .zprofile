# History
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
HISTORY_IGNORE="(ls|cd|pwd|exit|cd)*"

setopt EXTENDED_HISTORY   # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY # Write to the history file immediately, not when the shell exits.
setopt HIST_REDUCE_BLANKS # Remove superfluous blanks before recording entry.
setopt HIST_FIND_NO_DUPS  # Don't display duplicates when searching history.

# Initialize Homebrew environment
HOMEBREW_PREFIX="/opt/homebrew"
command -v ${HOMEBREW_PREFIX}/bin/brew &>/dev/null && eval "$(${HOMEBREW_PREFIX}/bin/brew shellenv)"
