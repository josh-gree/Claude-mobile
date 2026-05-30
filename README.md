# Claude-mobile

Repository created: 2026-05-30

---

## Execution Environment

### Compute Resources
| Resource | Value |
|---|---|
| CPUs | 4 vCPUs |
| RAM | 15 GB |
| Disk | 252 GB total, ~31 GB free |
| GPU | None |
| Swap | None |

### Available Runtimes & Tools
| Tool | Version |
|---|---|
| Python | 3.11.15 |
| Node.js | 22.22.2 |
| npm | 10.9.7 |
| Git | system |
| Docker | 29.3.1 (overlayfs, cgroup v1) |

### Network Access
All traffic is routed through a proxy (`CLAUDE_CODE_PROXY_RESOLVES_HOSTS=true`).

| Destination | Status |
|---|---|
| pypi.org | Allowed |
| registry.npmjs.org | Allowed |
| GitHub (via MCP tools / local git proxy) | Allowed |
| Docker Hub (cloudfront.docker.com) | Allowed |
| General internet (google.com, example.com, etc.) | Allowed |

### Docker
The Docker daemon is not started automatically (no systemd). Start it via `scripts/start-docker.sh`.

Pulling images from Docker Hub is supported in the full environment.
