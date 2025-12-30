#!/bin/bash
# Cloud Claude Code Setup Script
# Run this on your Hetzner VPS after SSH in

set -e

echo "=== Setting up Claude Code Cloud Environment ==="

# Update system
sudo apt update && sudo apt upgrade -y

# Install Node.js 20
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# Install essential tools
sudo apt install -y git tmux curl jq

# Install Claude Code globally
sudo npm install -g @anthropic-ai/claude-code

# Create claude config directory
mkdir -p ~/.claude

# Set up tmux for persistent sessions
cat > ~/.tmux.conf << 'TMUX'
set -g mouse on
set -g history-limit 50000
set -g default-terminal "screen-256color"
set -g status-bg black
set -g status-fg white
set -g status-right '#H | %H:%M'
TMUX

echo ""
echo "=== Setup Complete ==="
echo ""
echo "Next steps:"
echo "1. Run: claude login"
echo "2. Copy your ~/.claude folder from Mac (MCP configs, agents, etc)"
echo "3. Start tmux session: tmux new -s claude"
echo "4. Run: claude"
echo ""
echo "To reconnect later: tmux attach -t claude"
