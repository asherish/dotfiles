# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).  
Currently supports Ubuntu 22.04 / 24.04 (bare metal and Docker containers) and Windows (Git Bash + WezTerm), with macOS support planned.

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
| Herdr | herdr-core via official installer, updated on every apply (bare metal only); Herdr desktop app (Windows) |
| Codex | CLI install via mise, shared agent instructions, synced MCP config, external skills |

### Installed Tools (via mise)

**All environments:**

neovim, fzf, lazygit, yazi, glow, zoxide, jq, yq, bat, btop, eza, ripgrep, fd, delta, direnv, atuin, prek, gh, starship

**Bare metal only (non-container):**

uv, node, yarn, ghq, gwq, dotenvx, lazydocker, duckdb, dust, hyperfine, navi, procs, sheldon, Codex CLI, TinyTeX

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
- Install the Herdr desktop app with its official installer, if missing
- Deploy configuration files: `.bashrc`, `.profile`, `.gitconfig`, `.wezterm.lua`, and `.claude/` settings

---

## Remote Access from the Herdr Desktop App

The [Herdr desktop app](https://github.com/herdrdev/herdr-app) can run terminals on a remote Linux machine over SSH. On the remote side, the terminals live in [herdr-core](https://github.com/herdrdev/herdr-core) (`hc`).

- **Windows**: `chezmoi apply` installs the app with its official installer if it is missing (this also installs the local herdr-core). After that, the app updates itself and moves its local core to the latest release.
- **Bare-metal Linux**: `chezmoi apply` installs herdr-core into `~/.local/bin` and updates it to the latest release on every run, so the remote does not fall behind the app's core. It also enables systemd linger so remote terminals survive logout. Network failures only print a warning.

Machine registrations are per-device state and are not managed by these dotfiles.

### Adding a Remote Machine

1. Apply the dotfiles on the remote Linux machine (see [Initial Setup on New Machine](#initial-setup-on-new-machine)).

2. On Windows, make sure `ssh <ssh-config-host>` logs in with an SSH key or ssh-agent without any prompt. hc connects non-interactively and does not support password logins. Accept the host key once by connecting manually.

3. Check that a non-interactive login finds `hc` and prints nothing extra:

   ```bash
   ssh <ssh-config-host> hc --version   # Prints the version
   ssh <ssh-config-host> true | wc -c   # Prints 0
   ```

4. Add the machine in the app via **Settings → Machines → Add machine**, or from a terminal:

   ```bash
   hc machine add <ssh-config-host> --name <name>
   ```

### Notes

- Choose the machine name up front and avoid renaming it after adding.
- The connection carries a byte protocol over SSH, so the remote login must not print anything to stdout (for example, an `echo` in `~/.zshenv`).
- If `hc machine ls` shows `! stops at logout`, linger is not enabled on the remote. Run `sudo loginctl enable-linger -- <user>` there once, or re-run `chezmoi apply` in a terminal there and let it use sudo. The warning clears automatically.
- If `chezmoi apply` on the remote warns that a herdr-core release belongs to another protocol generation, update the Herdr desktop app first, then re-run `chezmoi apply`.

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
