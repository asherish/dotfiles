# TODO

## Phase 1: Enhance Current Dotfiles

### Configuration

- [x] Shell: migrate to zsh and configure prompt (starship)
- [x] Neovim `init.lua` (LazyVim)
- [x] lazygit `config.yml`

## Phase 2: Container Support

- [x] Add `is_container` flag to `.chezmoi.toml.tmpl`
- [x] Skip apt scripts in containers (packages managed by Dockerfile)
- [x] Install only a subset of mise tools in containers (editor + CLI only)

## Phase 3: Expand Packages and Tools

### apt packages

- [ ] Basic: `unzip`(installed), `tar`(installed), `p7zip-full`, `rsync`(installed), `xclip`(installed), `xsel`, `gpg`(installed), `watch` (`zsh` addressed in Phase 1)
- [x] Build: `cmake`, `pkg-config` (`build-essential` installed)
- [x] Libraries: `libssl-dev`, `libffi-dev`, `libsqlite3-dev`, `libbz2-dev`, `libreadline-dev`, `libncurses-dev`, `zlib1g-dev`, `liblzma-dev`
- [x] Docker: `docker-ce`, `docker-ce-cli`, `docker-compose-plugin`
- [ ] Monitoring: `nvtop`(installed), `aptitude`

### mise tools

- [x] Runtimes: `uv`, `node`, `yarn`
- [ ] Runtimes: `rust`
- [x] CLI (installed): `lazygit`, `yazi`, `fzf`, `glow`, `neovim`, `direnv`, `atuin`, `dust`, `hyperfine`, `navi`, `procs`, `duckdb`
- [ ] CLI (remaining): `sd`

### zsh plugins (zinit)

- [x] `zsh-autosuggestions`
- [x] `zsh-syntax-highlighting`
- [x] `zsh-sudo`
- [ ] Migrate plugin manager from zinit to sheldon

### Applications

- [x] Claude Code (installation script, settings, hooks, CLAUDE.md managed via chezmoi)

## Phase 4: Cross-Platform

- [ ] macOS support (Homebrew, `.chezmoiscripts/darwin/`)
- [x] Windows support (Git Bash, WezTerm, `.chezmoiignore` OS branching)

## Phase 5: Infrastructure & Automation

- [ ] VS Code extensions bulk install script
- [ ] Secret management with 1Password CLI
- [ ] CI testing with GitHub Actions (`chezmoi apply` on clean VM)

