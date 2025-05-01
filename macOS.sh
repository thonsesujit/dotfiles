#!/usr/bin/env zsh

# Check if Xcode Command Line Tools are installed
if ! xcode-select -p &>/dev/null; then
    echo "Xcode Command Line Tools not found. Installing..."
    xcode-select --install
    echo "Complete the installation of Xcode Command Line Tools before proceeding."
    echo "Press enter to continue..."
    read
else
    echo "Xcode Command Line Tools are already installed. Skipping installation."
fi

echo "Complete the installation of Xcode Command Line Tools before proceeding."
echo "Press enter to continue..."
read

# Set scroll as traditional instead of natural. Uncomment the line below to enable.
# defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
# killall Finder

# Set location for screenshots
mkdir "${HOME}/Documents/Screenshots"
defaults write com.apple.screencapture location "${HOME}/Documents/Screenshots"
killall SystemUIServer

# Add Bluetooth to Menu Bar for battery percentages
defaults write com.apple.controlcenter "NSStatusItem Visible Bluetooth" -bool true
killall ControlCenter

# Get the absolute path to the image
IMAGE_PATH="${HOME}/dotfiles/settings/Desktop.png"

# AppleScript command to set the desktop background
osascript <<EOF
tell application "System Events"
    set desktopCount to count of desktops
    repeat with desktopNumber from 1 to desktopCount
        tell desktop desktopNumber
            set picture to "$IMAGE_PATH"
        end tell
    end repeat
end tell
EOF
