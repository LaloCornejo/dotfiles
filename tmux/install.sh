#!/bin/bash

# Tmux Plugin Manager and Plugins Installation Script

echo "🚀 Setting up Tmux with enhanced configuration..."

# Check if tmux is installed
if ! command -v tmux &> /dev/null; then
    echo "❌ Tmux is not installed. Please install tmux first."
    exit 1
fi

# Create tmux plugin directory if it doesn't exist
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "📦 Installing Tmux Plugin Manager (TPM)..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
    echo "✅ TPM already installed"
fi

# Check if configuration exists
if [ -f "$HOME/.dotfiles/tmux/tmux.conf" ]; then
    echo "✅ Tmux configuration found"
else
    echo "❌ Tmux configuration not found at ~/.dotfiles/tmux/tmux.conf"
    exit 1
fi

# Create symlink if needed (assuming you use stow or similar)
if [ ! -f "$HOME/.tmux.conf" ]; then
    echo "🔗 Creating symlink to tmux configuration..."
    ln -s "$HOME/.dotfiles/tmux/tmux.conf" "$HOME/.tmux.conf"
else
    echo "✅ Tmux configuration already linked"
fi

echo "🔧 Starting tmux and installing plugins..."

# Start a detached tmux session to install plugins
tmux new-session -d -s plugin-install

# Install plugins
tmux send-keys -t plugin-install 'tmux source ~/.tmux.conf' Enter
sleep 2
tmux send-keys -t plugin-install 'C-a I' # Install plugins
sleep 5

# Kill the temporary session
tmux kill-session -t plugin-install

echo "✅ Tmux setup complete!"
echo ""
echo "📚 Next steps:"
echo "1. Start tmux: tmux"
echo "2. Use Ctrl-A + o to open sessionx"
echo "3. Check the cheat sheet: ~/.dotfiles/tmux/CHEATSHEET.md"
echo "4. If plugins didn't install, manually press Ctrl-A + I in tmux"
echo ""
echo "🎯 Key features now available:"
echo "  • SessionX for session management (Ctrl-A + o)"
echo "  • Floating terminal (Ctrl-A + p)"
echo "  • Vim-tmux navigation (Ctrl-h/j/k/l)"
echo "  • Enhanced copy mode with clipboard integration"
echo "  • URL extraction and opening"
echo "  • Session resurrection"
echo ""
echo "Happy tmuxing! 🎉"