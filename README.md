# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).  
Currently supports Ubuntu 24.04, with macOS and Windows support planned.

---

## Initial Setup on New Machine

### Installing Prerequisites

Run following commands to install required packages:

```bash
# Update package lists and install prerequisites
sudo apt update
sudo apt install -y curl git gh
```

### Generating and Registering SSH Keys

```bash
# Add SSH key to GitHub
gh ssh-key add ~/.ssh/id_ed25519_github.pub --title "$(whoami)@$(hostname -s)"
```

### Installing chezmoi and Applying Configuration

```bash
# Install chezmoi, clone repository, and apply configuration
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply git@github.com:asherish/dotfiles.git
```

This command will:

- Install chezmoi
- Clone this repository
- Run setup scripts (apt packages, GUI apps, mise, etc.)
- Deploy all configuration files

Optionally, you can also manually register API keys, SSH keys, or other credentials if needed.

---

## Daily Workflow

### Modifying Dotfiles

Always edit dotfiles in the source directory, not in your home directory. This keeps templates safe and ensures the source directory is the single source of truth.

```bash
# Edit single file in the source directory
chezmoi edit ~/.bashrc
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
git commit -m "Update bashrc"

# Push changes to remote repository
git push
```

### Updating on Another Machine

```bash
# Pull changes from remote and apply to your home directory
chezmoi update
```

This runs `git pull` and `chezmoi apply` in one step to synchronize your home directory with the source directory.

