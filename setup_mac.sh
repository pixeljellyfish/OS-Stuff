#!/bin/bash

# Script to automate Mac setup with colored output
echo "Starting MacBook setup on $(date)..."
echo "This script will install Homebrew, command-line tools, and GUI apps."
echo "It will also apply system settings to customize your Mac."
echo "Please wait while the script runs..."

# ANSI color codes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to log messages with color
log() {
    local color="$2"
    [ -z "$color" ] && color="$GREEN" # Default to green if no color specified
    echo -e "${color}[$(date +'%H:%M:%S')] $1${NC}"
}

# Check if Homebrew is installed, install if not
if ! command -v brew &> /dev/null; then
    log "Installing Homebrew..." "$YELLOW"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" &> /dev/null
    log "Homebrew installed." "$GREEN"
    # Add Homebrew to PATH for this session
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    log "Homebrew already installed. Updating..." "$YELLOW"
    brew update &> /dev/null
    log "Homebrew updated." "$GREEN"
fi

# Install command-line tools
log "Installing command-line tools..." "$YELLOW"
xcode-select --install &> /dev/null || log "Xcode tools already installed." "$GREEN"

# List of CLI tools to install via Homebrew
cli_tools=("git" "node" "python3" "wget"" ")
for tool in "${cli_tools[@]}"; do
    log "Installing $tool..." "$YELLOW"
    if brew install "$tool" &> /dev/null; then
        log "$tool installed successfully." "$GREEN"
    else
        log "Failed to install $tool." "$RED"
    fi
done

# List of GUI apps to install via Homebrew Cask
apps=("visual-studio-code" "slack" "brave" "iterm2" "raycast" "spotify") # Add more apps here
for app in "${apps[@]}"; do
    log "Installing $app..." "$YELLOW"
    if brew install --cask "$app" &> /dev/null; then
        log "$app installed successfully." "$GREEN"
    else
        log "Failed to install $app." "$RED"
    fi
done

# Apply macOS settings
log "Applying system settings..." "$YELLOW"

# Enable dark mode
defaults write NSGlobalDomain AppleInterfaceStyle Dark &> /dev/null
log "Dark mode enabled." "$GREEN"

# Minimize Dock animation and set auto-hide
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 36
defaults write com.apple.dock minimize-to-application -bool true
killall Dock &> /dev/null
log "Dock settings applied." "$GREEN"

# Show hidden files in Finder
defaults write com.apple.finder AppleShowAllFiles -bool true
killall Finder &> /dev/null
log "Hidden files now visible in Finder." "$GREEN"

# Set screenshot location to ~/Screenshots
mkdir -p ~/Screenshots
defaults write com.apple.screencapture location ~/Screenshots
killall SystemUIServer &> /dev/null
log "Screenshot location set to ~/Screenshots." "$GREEN"

# Finalize
log "Setup complete! Enjoy your new MacBook." "$BLUE"
echo "Installed apps are in /Applications. Check logs above for any errors."