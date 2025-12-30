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
- Subscribe to topic: `hillway-claude-matt`
- (This is your private topic for permission notifications)

### 6. Configure Terminus (iPhone)

**Option A: Import SSH Key via Mac App (Recommended)**
1. Open Terminus on Mac
2. Go to Settings → Keys
3. Click + and import `~/.ssh/id_ed25519`
4. This will sync to your iPhone via iCloud

**Option B: Import SSH Key Manually**
1. Email yourself the private key: `~/.ssh/id_ed25519`
2. Open in Terminus on iPhone → Import

**Create the Connection:**
1. Open Terminus on iPhone
2. Tap + to add new host
3. **Address:** `209.97.187.117`
4. **Username:** `root`
5. **Auth:** Select your imported SSH key
6. **Name:** `Claude Runner`
7. Save and connect

## Daily Usage

### From Mac
```bash
ssh root@209.97.187.117
tmux attach -t claude
# or start new session:
tmux new -s claude
claude
```

### From Phone (Terminus)
1. Open Terminus → Connect to "Claude Runner"
2. Run: `tmux attach -t claude`
3. You're now in the Claude session
4. Type prompts, approve/deny permissions

### Starting a Background Task
```bash
# On Mac or phone, start Claude in tmux:
ssh root@209.97.187.117
tmux new -s claude
claude
# Give it a task, then detach: Ctrl+B, then D
# Close laptop - it keeps running!
```

### Notifications
When Claude needs permission approval:
1. You'll get a push notification on your phone via ntfy
2. Open Terminus and connect
3. Run `tmux attach -t claude`
4. Type `y` or `n` to approve/deny

### Useful tmux Commands
- `Ctrl+B, D` - Detach (leave running)
- `Ctrl+B, [` - Scroll mode (q to exit)
- `tmux ls` - List sessions
- `tmux kill-session -t claude` - Kill session

## Files

- `setup-server.sh` - Initial server setup
- `sync-claude-config.sh` - Sync local config to server
- `~/.claude/hooks/ntfy-permission-hook.sh` - Notification hook
