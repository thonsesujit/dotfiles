#!/usr/bin/env zsh

# Check if Homebrew's bin exists and if it's not already in the PATH
if [ -x "/opt/homebrew/bin/brew" ] && [[ ":$PATH:" != *":/opt/homebrew/bin:"* ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
fi

# Install VS Code Extensions
extensions=(
    esbenp.prettier-vscode            # Prettier code formatter for consistent code styling
    formulahendry.code-runner         # Run code snippets or files directly in VS Code
    foxundermoon.shell-format         # Format shell scripts (Bash, Zsh, etc.)
    github.copilot                    # GitHub Copilot for AI-powered code suggestions
    github.copilot-chat               # Chat-based interface for GitHub Copilot
    mechatroner.rainbow-csv           # Highlight CSV files and provide tools for working with them
    teabyii.ayu                       # Ayu theme for VS Code
    tomoki1207.pdf                    # PDF viewer for VS Code
    ms-azuretools.vscode-docker       # Docker support for VS Code  
    ms-vscode-remote.remote-containers # Remote development with Docker containers
    dbaeumer.vscode-eslint           # ESLint integration for JavaScript and TypeScript
    github.vscode-pull-request-github   # GitHub Pull Request integration for VS Code
    oderwat.indent-rainbow           # Rainbow indentation for better readability
    sapse.sap-ux-fiori-tools-extension-pack # SAP Fiori tools for development
)

# Get a list of all currently installed extensions.
installed_extensions=$(code --list-extensions)

for extension in "${extensions[@]}"; do
    if echo "$installed_extensions" | grep -qi "^$extension$"; then
        echo "$extension is already installed. Skipping..."
    else
        echo "Installing $extension..."
        code --install-extension "$extension"
    fi
done

echo "VS Code extensions have been installed."

# Define the target directory for VS Code user settings on macOS
VSCODE_USER_SETTINGS_DIR="${HOME}/Library/Application Support/Code/User"

# Check if VS Code settings directory exists
if [ -d "$VSCODE_USER_SETTINGS_DIR" ]; then
    # Copy your custom settings.json and keybindings.json to the VS Code settings directory
    ln -sf "${HOME}/dotfiles/settings/VSCode-Settings.json" "${VSCODE_USER_SETTINGS_DIR}/settings.json"
    # ln -sf "${HOME}/dotfiles/settings/VSCode-Keybindings.json" "${VSCODE_USER_SETTINGS_DIR}/keybindings.json"

    echo "VS Code settings and keybindings have been updated."
else
    echo "VS Code user settings directory does not exist. Please ensure VS Code is installed."
fi

# Open VS Code to sign-in to extensions
# code .
# echo "Login to extensions (Copilot, Grammarly, etc) within VS Code."
# echo "Press enter to continue..."
# read
