# Cloud Claude Code Setup

Run Claude Code on a cloud server so it works while your laptop sleeps.

## Architecture

```
┌─────────────────┐     ┌──────────────────┐     ┌─────────────┐
│  Hetzner VPS    │────▶│    ntfy.sh       │────▶│  Your Phone │
│  Claude Code    │     │  Push Service    │     │  ntfy app   │
│  (in tmux)      │     └──────────────────┘     │  Terminus   │
└─────────────────┘                              └─────────────┘
         ▲                                              │
         │              SSH via Terminus                │
         └──────────────────────────────────────────────┘
```

## Quick Start

### 1. Create Hetzner Account
- Go to https://console.hetzner.cloud/
- Sign up with email
- Add SSH key from: `~/.ssh/id_ed25519.pub`

### 2. Create Server
- Location: Falkenstein (eu-central) or Nuremberg
- Image: Ubuntu 24.04
- Type: CX22 (2 vCPU, 4GB RAM) - €4.51/mo
- SSH key: Select your key
- Name: claude-runner

### 3. Set Up Server
```bash
ssh root@<server-ip>
# Run setup script
curl -sSL https://raw.githubusercontent.com/matthillway/cloud-claude-setup/main/setup-server.sh | bash
```

Or copy the script:
```bash
scp ~/Projects/cloud-claude-setup/setup-server.sh root@<server-ip>:~/
ssh root@<server-ip> 'chmod +x setup-server.sh && ./setup-server.sh'
```

### 4. Sync Claude Config
```bash
cd ~/Projects/cloud-claude-setup
./sync-claude-config.sh <server-ip>
```

### 5. Set Up ntfy
- Open ntfy app on phone
- Subscribe to topic: `hillway-claude`
- (Use a unique topic name only you know)

### 6. Configure Terminus
- Add new host: `<server-ip>`
- Username: `root`
- Auth: SSH Key (import from ~/.ssh/id_ed25519)

## Daily Usage

### From Mac
```bash
ssh root@<server-ip>
tmux attach -t claude
# or start new: tmux new -s claude
claude
```

### From Phone (Terminus)
1. Open Terminus
2. Connect to your server
3. `tmux attach -t claude`
4. Interact with Claude

### Notifications
When Claude needs permission, you'll get a push notification on your phone.
SSH in via Terminus to approve/deny.

## Files

- `setup-server.sh` - Initial server setup
- `sync-claude-config.sh` - Sync local config to server
- `~/.claude/hooks/ntfy-permission-hook.sh` - Notification hook
