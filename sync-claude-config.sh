#!/bin/bash
# Sync Claude Code config to remote server
# Usage: ./sync-claude-config.sh <server-ip>

SERVER_IP=$1

if [ -z "$SERVER_IP" ]; then
  echo "Usage: ./sync-claude-config.sh <server-ip>"
  exit 1
fi

echo "Syncing Claude config to $SERVER_IP..."

# Sync .claude directory (agents, settings, etc)
rsync -avz --progress \
  --exclude 'projects/' \
  --exclude 'statsig/' \
  --exclude '*.log' \
  ~/.claude/ root@$SERVER_IP:~/.claude/

# Sync API keys (if stored in env file)
if [ -f ~/.anthropic_api_key ]; then
  scp ~/.anthropic_api_key root@$SERVER_IP:~/
fi

echo ""
echo "Done! SSH to server and run 'claude' to start"
