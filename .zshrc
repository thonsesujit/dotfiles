# Load colors and enable prompt substitution
autoload -Uz colors && colors
setopt PROMPT_SUBST

# Zsh options for safer and more convenient behavior
setopt rmstarsilent          # Don't ask for confirmation when using rm with wildcards
setopt no_nomatch            # Return an empty string if wildcard pattern has no matches
setopt SHARE_HISTORY         # Share command history across all open sessions
setopt APPEND_HISTORY        # Append history rather than overwriting it
setopt HIST_REDUCE_BLANKS    # Remove superfluous blanks from history
setopt HIST_IGNORE_SPACE     # Ignore commands starting with a space
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicates first when trimming history

# History file configuration
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

# Load additional dotfiles if they exist
for file in ~/.{zprompt,aliases,private}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Add custom paths to PATH
export PATH="$PATH:/Users/I540546/.local/bin"

# Homebrew prefix (store in a variable to avoid repetition)
BREW_PREFIX=$(brew --prefix 2>/dev/null || echo "/opt/homebrew")

# Z package configuration
if [ -f "$BREW_PREFIX/etc/profile.d/z.sh" ]; then
    source "$BREW_PREFIX/etc/profile.d/z.sh"
    export _Z_NO_PROMPT_COMMAND=1  # Disable prompt command for better performance
    export _Z_DATA=~/.z  # Specify the data file for z
else
    echo "z not found. Please ensure it is installed via Homebrew."
fi

# Enable zsh-autosuggestions
if [ -f "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
else
    echo "zsh-autosuggestions not found. Please ensure it is installed via Homebrew."
fi

# Enable zsh-syntax-highlighting
if [ -f "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
else
    echo "zsh-syntax-highlighting not found. Please ensure it is installed via Homebrew."
fi

# Add Starship prompt initialization
if command -v starship &>/dev/null; then
    eval "$(starship init zsh)"
    export STARSHIP_CONFIG=~/.config/starship/starship.toml
else
    echo "Starship prompt not found. Please ensure it is installed."
fi

# Enable fzf key bindings and auto-completion
if [ -f "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh" ]; then
    source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
fi

if [ -f "$(brew --prefix)/opt/fzf/shell/completion.zsh" ]; then
    source "$(brew --prefix)/opt/fzf/shell/completion.zsh"
fi