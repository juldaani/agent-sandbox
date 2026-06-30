# agent-sandbox

Generic agent sandbox for misc R&D tasks — running arbitrary code, exploring
repos, parsing data, writing snippets, and small coding tasks.

Uses [DevPod](https://devpod.sh/) to run a two-container stack:

| Container | Purpose | Base Image |
|-----------|---------|------------|
| **sandbox** | Dev environment with Pi coding agent + AivoCode CLI | `pi-cpu` |
| **aivocode** | REST API server (LSP, web ops, codebase analysis) | `cpu-dev` |

## Quick Start

1. **Install DevPod**: <https://devpod.sh/docs/getting-started/install>

2. **Configure environment**:
   ```bash
   # AivoCode sidecar (API keys)
   cp .aivocode.env.example .aivocode.env
   # Edit .aivocode.env with your Exa API key

   # DevPod workspace (Nextcloud sync credentials)
   cp workspace.env.example workspace.env
   # Edit workspace.env with your Nextcloud credentials
   ```

3. **Start the sandbox**:
   ```bash
   devpod up . --ide none --provider docker --workspace-env-file ./workspace.env
   ```

4. **SSH in**:
   ```bash
   ssh agent-sandbox.devpod
   ```

5. **Or open in VS Code**:
   ```bash
   devpod up . --ide vscode --provider docker --workspace-env-file ./workspace.env
   ```

## What's Inside

- **Pi coding agent** (`pi`) — terminal TUI for AI-assisted coding
- **AivoCode CLI** (`aivocode`) — LSP symbols, web fetch, web search via the sidecar
- **Python 3.12** with numpy, pandas, scipy, matplotlib, requests, httpx, bs4, openpyxl
- **Node.js 22.x** (required by Pi)
- **Nextcloud sync** — configs, sessions, and workspace backup via rclone

## AivoCode Sidecar

The `aivocode` container runs a FastAPI server on port 8000 providing:
- LSP-powered code intelligence (symbols, references, hover)
- Web fetching (Crawl4AI browser)
- Web search (Exa API)
- Codebase import graph analysis
- File watching

The sandbox container communicates with the sidecar via `AIVOCODE_URL=http://aivocode:8000`.

## Sync Configuration

Edit `workspace.env` to configure Nextcloud rclone sync:

| Path | What | Direction |
|------|------|-----------|
| 1 | Pi extensions | Bidirectional |
| 2 | Pi themes | Bidirectional |
| 3 | Pi sessions (JSONL) | Bidirectional |
| 4 | Pi config / skills / prompts | Cloud → Container |
| 5 | Workspace backup | Container → Cloud |

## Requirements

- [DevPod](https://devpod.sh/) (or VS Code Dev Containers)
- Docker
- Nextcloud WebDAV credentials (for sync)
- Exa API key (for web search in AivoCode)
