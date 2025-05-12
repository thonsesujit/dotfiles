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

# # load jenv in conventional way. Uncomment if you want to use it. But comment Lazy load zenv
# export PATH="$HOME/.jenv/bin:$PATH"
# eval "$(jenv init -)"


# Lazy load jenv
_lazy_jenv_init() {
    unset -f java javac jenv
    export PATH="$HOME/.jenv/bin:$PATH"
    eval "$(jenv init -)"
    command "$@"
}

# Lazy load jenv commands
java()  { _lazy_jenv_init java "$@"; }
javac() { _lazy_jenv_init javac "$@"; }
jenv()  { _lazy_jenv_init jenv "$@"; }


### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# Lazy load fnm
_lazy_fnm_init() {
    unset -f node npm npx fnm
    FNM_PATH="/Users/I540546/Library/Application Support/fnm"
    if [ -d "$FNM_PATH" ]; then
        export PATH="/Users/I540546/Library/Application Support/fnm:$PATH"
        eval "`fnm env`"
    fi
    export PATH=/home/$USER/.fnm:$PATH
    eval "$(fnm env --use-on-cd --version-file-strategy=recursive)"
    command "$@"
}

# Lazy load fnm commands
node() { _lazy_fnm_init node "$@"; }
npm()  { _lazy_fnm_init npm "$@"; }
npx()  { _lazy_fnm_init npx "$@"; }
fnm()  { _lazy_fnm_init fnm "$@"; }