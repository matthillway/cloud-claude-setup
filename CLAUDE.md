# Cloud Claude Setup - Project Status

## Current State: ✅ FULLY OPERATIONAL

### Server Details
- **Provider:** DigitalOcean
- **IP:** 209.97.187.117
- **OS:** Ubuntu 24.04
- **Cost:** $6/month

### What's Installed
- Claude Code v2.0.76
- Node.js 20
- tmux (for persistent sessions)
- jq (for hook JSON parsing)

### Configuration Synced
- Custom agents (6 Hillway-specific agents)
- Settings (permissions, hooks)
- ntfy notification hook

### ntfy Setup
- **Topic:** `hillway-claude-matt`
- **Hook:** `/root/.claude/hooks/ntfy-permission.sh`
- Triggers on all PermissionRequest events

## Quick Reference

### Start Claude Session
```bash
ssh root@209.97.187.117
tmux new -s claude
claude
```

### Attach to Existing Session
```bash
ssh root@209.97.187.117
tmux attach -t claude
```

### Sync Config from Mac
```bash
cd ~/Projects/cloud-claude-setup
./sync-claude-config.sh 209.97.187.117
```

## Files
- `setup-server.sh` - Server initialization script
- `sync-claude-config.sh` - Sync Mac config to server
- `README.md` - Full documentation

## GitHub
- Repo: matthillway/cloud-claude-setup
