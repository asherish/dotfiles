# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).  
Currently supports Ubuntu 24.04 (bare metal and Docker containers) and Windows (Git Bash + WezTerm), with macOS support planned.

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
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply --use-builtin-git true https://github.com/asherish/dotfiles.git
```

This command will:

- Install chezmoi
- Clone this repository
- Run setup scripts (apt packages, Docker, Tailscale, Claude Code, mise, etc.)
- Deploy all configuration files

### Generating and Registering SSH Keys

After chezmoi has finished setup (which installs `gh` via mise), register your SSH key and switch the remote to SSH:

```bash
# Add SSH key to GitHub
gh ssh-key add ~/.ssh/id_ed25519_github.pub --title "$(whoami)@$(hostname -s)"

# Switch remote URL from HTTPS to SSH
git -C ~/.local/share/chezmoi remote set-url origin git@github.com:asherish/dotfiles.git
```

Optionally, you can also manually register API keys, SSH keys, or other credentials if needed.

---

## Container Setup

When running inside a Docker container, chezmoi automatically detects the container environment via `/.dockerenv` or the `container` environment variable and adjusts its behavior:

- **Shell**: Uses bash instead of zsh
- **System scripts**: Skips apt package installation, Docker setup, Tailscale setup, and sshd configuration (managed by Dockerfile)
- **mise tools**: Installs only essential tools (neovim, fzf, lazygit, yazi, glow, starship), skipping uv, node, and yarn

Apply dotfiles after the container is running:

```bash
# Install chezmoi and apply dotfiles inside a running container
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply --use-builtin-git true https://github.com/asherish/dotfiles.git
```

---

## Windows Setup

### Installing Prerequisites

1. Install [Git for Windows](https://gitforwindows.org/) from the official site
2. Install [WezTerm](https://wezfurlong.org/wezterm/installation.html) from the official site

### Installing chezmoi and Applying Configuration

Open Git Bash and run:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/asherish/dotfiles.git
```

This command will:

- Install chezmoi
- Clone this repository
- Deploy configuration files: `.bashrc`, `.profile`, `.gitconfig`, `.wezterm.lua`, and `.claude/` settings

### What Gets Deployed on Windows

| File | Purpose |
|------|---------|
| `.bashrc` | Git Bash interactive shell config |
| `.profile` | Git Bash environment config |
| `.gitconfig` | Git global config (with Windows-specific settings) |
| `.wezterm.lua` | WezTerm terminal emulator config |
| `.claude/` | Claude Code settings and hooks |

---

## Daily Workflow

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

