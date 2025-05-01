autoload -Uz colors && colors
setopt PROMPT_SUBST

# Don't ask if user is sure when running rm with wildcards (like bash)
setopt rmstarsilent

# If wildcard pattern has no matches, return an empty string (like bash)
setopt no_nomatch

# Specify the history file and its sizes
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

# These options improve history behavior across sessions
setopt SHARE_HISTORY          # Share command history across all open sessions
setopt APPEND_HISTORY         # Append history rather than overwriting it
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks from each command line being added to the history list
setopt HIST_IGNORE_SPACE      # Ignore commands that start with a space (for secret or experimental commands)
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicates first when trimming history

# Load dotfiles:
for file in ~/.{zprompt,aliases,private}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Created by pipx
export PATH="$PATH:/Users/I540546/.local/bin"

# Z package configuration
if [ -f "/opt/homebrew/etc/profile.d/z.sh" ]; then
    . /opt/homebrew/etc/profile.d/z.sh
    export _Z_NO_PROMPT_COMMAND=1  # Disable prompt command for better performance
    export _Z_DATA=~/.z  # Specify the data file for z
else
    echo "z not found. Please ensure it is installed via Homebrew."
fi

# Enable zsh-autosuggestions
if [ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
else
    echo "zsh-autosuggestions not found. Please ensure it is installed via Homebrew."
fi

# Enable zsh-syntax-highlighting
if [ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
else
    echo "zsh-syntax-highlighting not found. Please ensure it is installed via Homebrew."
fi

# Add Starship prompt initialization
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml
