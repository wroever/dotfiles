# Skip if not running interactively
[[ $- == *i* ]] || return

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{extras,path,aliases,functions,exports}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Append to history, don't overwrite it
type shopt &> /dev/null && shopt -s histappend
