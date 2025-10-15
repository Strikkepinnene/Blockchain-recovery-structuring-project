# IDL Docker Team Development Setup

## Quick Start

1. **Start the team environment:**
   ```bash
   docker-compose up -d
   ```

2. **Connect to the development container:**
   ```bash
   docker exec -it idl-team-workspace /bin/bash
   ```

3. **Access IDL in the container:**
   ```bash
   cd /home/idldev/workspace
   idl
   ```

## Container Services

### idl-team-dev (Main Development)
- **Ports:** 4080 (IDL), 2222 (SSH), 5900 (VNC)
- **Access:** `ssh -p 2222 idldev@localhost` (password: idlteam)
- **Purpose:** Primary development environment with full IDL/ENVI

### idl-team-server (Shared Processing)
- **Ports:** 4081 (IDL), 2223 (SSH)
- **Access:** For running shared computational tasks
- **Purpose:** Server instance for team processing workflows

### envi-processor (Image Processing)
- **Ports:** 4082 (IDL)
- **Purpose:** Dedicated ENVI headless processing for image analysis

## Volume Mapping
- `./src` → `/home/idldev/workspace/src` (IDL source code)
- `./data` → `/home/idldev/workspace/data` (datasets)
- `./notebooks` → `/home/idldev/workspace/notebooks` (IDL notebooks)
- `./shared` → `/home/idldev/workspace/shared` (team shared files)

## Team Collaboration Workflow

1. **Start containers:** `docker-compose up -d`
2. **Open VS Code:** `code .`
3. **Start Live Share session** for real-time collaboration
4. **Connect teammates to containers:**
   - Share SSH access: `ssh -p 2222 idldev@YOUR_IP`
   - Share VNC access: `YOUR_IP:5900`
   - Share IDL ports: `YOUR_IP:4080-4082`

## Container Management

```bash
# View running containers
docker-compose ps

# View container logs
docker-compose logs idl-team-dev

# Stop all containers
docker-compose down

# Rebuild containers (after changes)
docker-compose build --no-cache

# Scale ENVI processors for heavy workloads
docker-compose up -d --scale envi-processor=3
```

## Security Notes

- Default passwords are for development only - change for production
- Containers run with standard user 'idldev' (not root)
- SSH keys should be mounted for secure access
- IDL license must be properly configured (see Dockerfile)

## Troubleshooting

- **IDL not found:** Ensure IDL installation in Dockerfile
- **Permission errors:** Check volume mount permissions
- **Port conflicts:** Verify ports 4080-4082, 2222-2223, 5900 are available
- **X11 issues:** VNC provides GUI access when X11 forwarding fails