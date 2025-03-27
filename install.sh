#!/bin/bash

set -e

echo "▶️ Starting dotfiles installation..."

# ─────────────────────────────────────────────
# 🧠 Detect OS
# ─────────────────────────────────────────────
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "🧠 Detected macOS"

    # Install Homebrew if missing
    if ! command -v brew &>/dev/null; then
        echo "🧪 Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    echo "📦 Installing Neovim, Starship, and Tmux via Homebrew..."
    brew install neovim starship tmux

    echo "⚠️ Ghostty is not available via Homebrew. Please install it manually:"
    echo "   https://github.com/mitchellh/ghostty/releases"

elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "🐧 Detected Linux"

    # Install packages with apt or pacman
    if command -v apt &>/dev/null; then
        sudo apt update
        sudo apt install -y neovim starship tmux curl unzip
    elif command -v pacman &>/dev/null; then
        sudo pacman -Sy --noconfirm neovim starship tmux curl unzip
    else
        echo "❌ Unsupported package manager. Please install dependencies manually."
        exit 1
    fi

# ─────────────────────────────────────────────
# ⬇️ Install Ghostty (Linux)
# ─────────────────────────────────────────────
echo "⬇️ Installing Ghostty..."

# Get latest version tag from GitHub API
GHOSTTY_VERSION=$(curl -s https://api.github.com/repos/mitchellh/ghostty/releases/latest | grep '"tag_name":' | cut -d '"' -f 4)

if [[ -z "$GHOSTTY_VERSION" ]]; then
    echo "❌ Could not fetch latest Ghostty version. Please install manually."
    exit 1
fi

echo "📦 Latest Ghostty version: $GHOSTTY_VERSION"

GHOSTTY_URL="https://github.com/mitchellh/ghostty/releases/download/${GHOSTTY_VERSION}/ghostty-${GHOSTTY_VERSION}-linux-x86_64.zip"

mkdir -p ~/ghostty-install-tmp
cd ~/ghostty-install-tmp

echo "⬇️ Downloading Ghostty..."
curl -LO "$GHOSTTY_URL"
unzip ghostty-*.zip

sudo mv ghostty /usr/local/bin/
cd ~
rm -rf ~/ghostty-install-tmp

echo "✅ Ghostty installed to /usr/local/bin/ghostty"
# ─────────────────────────────────────────────
# 📁 Copy Configuration Files
# ─────────────────────────────────────────────
echo "📁 Copying config files..."

# Neovim
mkdir -p ~/.config/nvim
cp -r ./nvim/* ~/.config/nvim/

# Starship
mkdir -p ~/.config
cp ./starship.toml ~/.config/starship.toml

# Tmux
cp ./tmux/.tmux.conf ~/.tmux.conf

# Ghostty config
if [[ "$OSTYPE" == "darwin"* ]]; then
    mkdir -p ~/Library/Application\ Support/ghostty
    cp ./ghostty/ghostty.toml ~/Library/Application\ Support/ghostty/ghostty.toml
else
    mkdir -p ~/.config/ghostty
    cp ./ghostty/ghostty.toml ~/.config/ghostty/ghostty.toml
fi

echo "🎉 All done! Your development environment is now set up."
