# TODO

## Phase 1: Enhance Current Dotfiles

- [x] Shell: migrate to zsh and configure prompt (starship)
- [x] Neovim `init.lua` (LazyVim)
- [ ] lazygit `config.yml`

## Phase 2: Container Support

- [x] Add `is_container` flag to `.chezmoi.toml.tmpl`
- [x] Skip apt scripts in containers (packages managed by Dockerfile)
- [x] Install only a subset of mise tools in containers (editor + CLI only)

## Phase 3: Expand Packages and Tools

### apt packages

- [x] Basic: `ca-certificates`, `curl`, `git`, `gpg`, `p7zip-full`, `rsync`, `tar`, `tmux`, `unzip`, `wget`, `xclip`, `zsh`
- [x] Utilities: `chafa`, `openssh-server`, `poppler-utils`
- [x] Build: `build-essential`, `cmake`, `pkg-config`
- [x] Libraries: `libssl-dev`, `libffi-dev`, `libsqlite3-dev`, `libbz2-dev`, `libreadline-dev`, `libncurses-dev`, `zlib1g-dev`, `liblzma-dev`
- [x] Docker: `docker-ce`, `docker-ce-cli`, `docker-compose-plugin`
- [x] Monitoring: `nvtop`

### mise tools

- [x] Runtimes: `uv`, `node`, `yarn`
- [x] CLI: `atuin`, `bat`, `btop`, `delta`, `direnv`, `duckdb`, `dust`, `eza`, `fd`, `fzf`, `glow`, `hyperfine`, `jq`, `lazygit`, `navi`, `neovim`, `procs`, `ripgrep`, `starship`, `yazi`, `yq`, `zoxide`
- [x] CLI (non-container): `dotenvx`, `gh`, `ghq`, `gwq`, `lazydocker`

### zsh plugins (zinit)

- [x] `zsh-autosuggestions`
- [x] `zsh-syntax-highlighting`
- [x] `zsh-sudo`
- [ ] Migrate plugin manager from zinit to sheldon

### Applications

- [x] Claude Code (installation script, settings, hooks, CLAUDE.md)

## Phase 4: Cross-Platform

- [ ] macOS support (Homebrew, `.chezmoiscripts/darwin/`)
- [x] Windows support (Git Bash, WezTerm, `.chezmoiignore` OS branching)

## Phase 5: Infrastructure & Automation

- [ ] VS Code extensions bulk install script
- [ ] Secret management with 1Password CLI
- [ ] CI testing with GitHub Actions (`chezmoi apply` on clean VM)
