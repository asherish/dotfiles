# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).  
Currently supports Ubuntu 24.04 (bare metal and Docker containers) and Windows (Git Bash + WezTerm), with macOS support planned.

---

## What's Included

### Managed Configurations

| Category | Details |
|----------|---------|
| Shell | zsh (Linux) / bash (container/Windows), starship prompt |
| Editor | Neovim (LazyVim) |
| Terminal Multiplexer | tmux (Catppuccin theme, IDE layout) |
| Terminal Emulator | WezTerm (Windows) |
| Git | gitconfig, lazygit, delta (diff pager) |
| File Manager | yazi |
| Tool Manager | mise |
| Claude Code | settings, hooks, shared agent instructions, external skills |
| Codex | CLI install via mise, shared agent instructions, synced MCP config, external skills |

### Installed Tools (via mise)

**All environments:**

neovim, fzf, lazygit, yazi, glow, zoxide, jq, yq, bat, btop, eza, ripgrep, fd, delta, direnv, atuin, prek, gh, starship

**Bare metal only (non-container):**

uv, node, yarn, ghq, gwq, dotenvx, lazydocker, duckdb, dust, hyperfine, navi, procs, sheldon, Codex CLI

---

## Key Features

- **`repo`** — Select a ghq-managed repository with fzf and open it in an IDE layout
- **`ide [dir]`** — Create a VS Code-like tmux layout (left: nvim, right: terminal) with 50/50 split
- **tmux IDE tool switching** — Switch tools in the left pane with `prefix + e/y/g/D/b` or `prefix + Tab` menu (nvim / yazi / lazygit / lazydocker / btop)
- **Container auto-detection** — Detects container environments via `/.dockerenv` or `container` env var and adjusts installed tools and shell automatically

---

## Initial Setup on New Machine

### Installing Prerequisites

Run following commands to install required packages:

```bash
# Update package lists and install prerequisites
sudo apt update
sudo apt install -y curl git
```

### Installing chezmoi and Applying Configuration

```bash
# Install chezmoi, clone repository, and apply configuration
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin init --apply --use-builtin-git true https://github.com/asherish/dotfiles.git
```

This command will:

- Install chezmoi
- Clone this repository
- Install managed tools via mise (including Codex CLI on non-container Linux)
- Deploy all configuration files, install shared agent instructions, sync shared MCP servers to Claude Code and Codex, and install shared external skills

---

## Container Setup

When running inside a Docker container, chezmoi automatically detects the container environment via `/.dockerenv` or the `container` environment variable and adjusts its behavior:

- **Shell**: Uses bash instead of zsh
- **System scripts**: Skips apt package installation, Docker setup, Tailscale setup, and sshd configuration (managed by Dockerfile)
- **mise tools**: Installs only the "All environments" tools listed above, skipping bare-metal-only tools (uv, node, yarn, ghq, sheldon, Codex CLI, etc.)

### Manual Setup

Apply dotfiles after the container is running:

```bash
# Install chezmoi and apply dotfiles inside a running container
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin init --apply --use-builtin-git true https://github.com/asherish/dotfiles.git
```

### Devcontainer Dotfiles

For projects with `devcontainer.json`, dotfiles can be applied automatically:

```bash
devcontainer up --workspace-folder /path/to/project \
  --dotfiles-repository https://github.com/asherish/dotfiles.git
```

Or configure in VS Code settings:

```json
{
  "dotfiles.repository": "asherish/dotfiles"
}
```

The `install.sh` script at the repo root handles installing chezmoi and applying the configuration automatically.

---

## Windows Setup

### Installing Prerequisites

1. Install [Git for Windows](https://gitforwindows.org/) from the official site

### Installing chezmoi and Applying Configuration

Open Git Bash and run:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin init --apply https://github.com/asherish/dotfiles.git
```

This command will:

- Install chezmoi
- Clone this repository
- Install winget packages (WezTerm)
- Deploy configuration files: `.bashrc`, `.profile`, `.gitconfig`, `.wezterm.lua`, and `.claude/` settings

---

## Managing Dotfiles

### Modifying Dotfiles

Always edit dotfiles in the source directory, not in your home directory. This keeps templates safe and ensures the source directory is the single source of truth.

```bash
# Edit single file in the source directory
chezmoi edit ~/.zshrc
```

Or open entire source directory in editor:

```bash
# Change to the source directory
chezmoi cd
```

### Reviewing and Applying Changes

Check what would change, then apply to your home directory:

```bash
# Preview changes safely
chezmoi diff
chezmoi apply --dry-run --verbose

# Apply changes to your home directory
chezmoi apply
```

### Committing and Pushing to Repository

Commit changes in the source directory:

```bash
# Change to the source directory
chezmoi cd

# Stage and commit changes
git add -A
git commit -m "Update zshrc"

# Push changes to remote repository
git push
```

### Updating on Another Machine

```bash
# Pull changes from remote and apply to your home directory
chezmoi update
```

This runs `git pull` and `chezmoi apply` in one step to synchronize your home directory with the source directory.
